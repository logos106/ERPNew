/*
**************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
**************************************************************************
*/

function sgcws() {
  if (arguments.length == 0) return;
  
  if (arguments.length == 1) {
    if (typeof arguments[0] == "object") {
      arguments[0]["subprotocol"] = "esegece.com";
	  sgcWebSocket.call(this, arguments);
    } else if (typeof arguments[0] == "string") { 
      arguments[1] = "esegece.com";
	  sgcWebSocket.call(this, arguments[0], arguments[1]);
    }
  } else if (arguments.length == 2) {
    if (typeof arguments[0] == "object") {
      arguments[0]["subprotocol"] = arguments[1] + ".esegece.com";
	  sgcWebSocket.call(this, arguments);
    } else if (typeof arguments[0] == "string") { 
      arguments[1] = arguments[1] + ".esegece.com";
	  sgcWebSocket.call(this, arguments[0], arguments[1]);
    }  
  }
  
  var send_override = this.send;
  this.send = function(message, method, channel, id) {
    if (arguments.length == 1) {
	  arguments[0] = '{"jsonrpc":"2.0", "method":"sgc@message", "params":{"message":"' + message + '"}, "id":"' + GUID() + '"}'
	} else if (arguments.length == 2) {
	  arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":{"message":"' + message + '"}, "id":"' + GUID() + '"}'	
	} else if ((id !== '') && (id !== undefined)) {
	  arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":{"channel":"' + channel + '", "message":"' + message + '"}, "id":"' + id + '"}'
	} else {
	  arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":{"channel":"' + channel + '", "message":"' + message + '"}}'
	};
    send_override.apply(this, arguments);
  }     
  
  
  this.broadcast = function() {
	if (arguments.length == 1) {
      this.send(arguments[0], 'sgc@broadcast', '');
	} else if (arguments.length == 2) {
	  this.send(arguments[0], 'sgc@broadcast', arguments[1]);
	}
  }
  
  this.publish = function() {
    this.send(arguments[0], 'sgc@publish', arguments[1]);
  }  
   
  this.subscribe = function(channel) {
    this.send('', 'sgc@subscribe', channel, GUID());
  }
  
  this.unsubscribe = function(channel) {
    this.send('', 'sgc@unsubscribe', channel, GUID());
  }
  
  this.rpc = function(id, method, params) {
    arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":' + params + ', "id":"' + id + '"}';
    send_override.apply(this, arguments); 
  }
  
  this.notify = function(method, params) {
    arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":' + params + '"}';
    send_override.apply(this, arguments); 
  }  
  
  var evt_onsgcmessage = new event("onsgcmessage");   
  var evt_onsgcevent = new event("onsgcevent");   
  var evt_onsgcsubscribe = new event("onsgcsubscribe");
  var evt_onsgcunsubscribe = new event("onsgcunsubscribe");
  var evt_onsgcrpcresult = new event("onsgcrpcresult");
  var evt_onsgcrpcerror = new event("onsgcrpcerror");
   
  this.on('message', function(event) { 
    var json = event['message'];
    obj = JSON.parse(json);
	if (obj.result !== undefined){
      if (obj.result['method'] == "sgc@subscribe") {
        evt_onsgcsubscribe.fire(
        {
          name: 'onsgcsubscribe',
          channel: obj.result['channel']
        }
	    )
  	  } else if (obj.result['method'] == "sgc@unsubscribe") {
	    evt_onsgcunsubscribe.fire(
	    {
	      name: 'onsgcunsubscribe',
		  channel: obj.result['channel']
	    }
	    )
  	  } else if (obj.result['method'] == "sgc@event") {
        evt_onsgcevent.fire(
		{
          name: 'onsgcevent',
	      channel: obj.result['channel'],
          message: obj.result['message']			  
	    }
	    )				
  	  } else if (obj.result['method'] == "sgc@message") {
        evt_onsgcmessage.fire(
		{
          name: 'onsgcmessage',
          message: obj.result['message']		  
	    }
	    )			
	  } else {
	  evt_onsgcrpcresult.fire(
	    {
	      name: 'onsgcrpcresult',
		  result: obj.result,
		  id: obj.id
	    }
	    )  
	  }
	} else if (obj.error !== undefined){
	  evt_onsgcrpcerror.fire(
	  {
	    name: 'onsgcrpcerror',
		code: obj.error["code"],
		message: obj.error["message"],
		data: obj.error["data"]
	  }
	  )
	}
  });
  
  
  var on_override = this.on; 
  this.on = function (evtname, fn) {
  if (evtname == "sgcmessage") {
    evt_onsgcmessage.subscribe(fn);
  } else if (evtname == "sgcevent") {
    evt_onsgcevent.subscribe(fn);	
  } else if (evtname == "sgcsubscribe") {
    evt_onsgcsubscribe.subscribe(fn);
  } else if (evtname == "sgcunsubscribe") {
    evt_onsgcunsubscribe.subscribe(fn);
  } else if (evtname == "sgcrpcresult") {
    evt_onsgcrpcresult.subscribe(fn);		
  } else if (evtname == "sgcrpcerror") {
    evt_onsgcrpcerror.subscribe(fn);	
  } else {
    on_override.apply(this, arguments); 
  };
  };
  
}

sgcws.prototype = new sgcWebSocket();
sgcws.prototype.constructor = sgcws;

