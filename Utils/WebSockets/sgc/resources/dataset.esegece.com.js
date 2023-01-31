/*
**************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
**************************************************************************
*/

function sgcws_dataset() {
  if (arguments.length == 0) return;
  
  if (arguments.length == 1) {
    if (typeof arguments[0] == "object") {
      arguments[0]["subprotocol"] = "dataset.esegece.com";
	  sgcWebSocket.call(this, arguments);
    } else if (typeof arguments[0] == "string") { 
      arguments[1] = "dataset.esegece.com";
	  sgcWebSocket.call(this, arguments[0], arguments[1]);
    }
  } else if (arguments.length == 2) {
    if (typeof arguments[0] == "object") {
      arguments[0]["subprotocol"] = arguments[1] + ".dataset.esegece.com";
	  sgcWebSocket.call(this, arguments);
    } else if (typeof arguments[0] == "string") { 
      arguments[1] = arguments[1] + ".dataset.esegece.com";
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
	  arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":{"channel":"' + channel + '", "message":"' + message + '"}}'  
	} else {
	  arguments[0] = '{"jsonrpc":"2.0", "method":"' + method + '", "params":{"channel":"' + channel + '", "message":"' + message + '"}, "id":"' + id + '"}'  
	}
    send_override.apply(this, arguments);
  }  
  
  this.broadcast = function() {
	if (arguments.length == 1) {
      this.send(arguments[0], 'sgc@broadcast', '');
	} else if (arguments.length == 2) {
	  this.send(arguments[0], 'sgc@broadcast', arguments[1]);
	}
  }
   
  this.subscribe = function(channel) {
    this.send('', 'sgc@subscribe', channel, GUID());
  }
  
  this.unsubscribe = function(channel) {
    this.send('', 'sgc@unsubscribe', channel, GUID());
  }  
  
 
  this.subscribe_all = function() {
	this.subscribe("sgc@dataset@new");
	this.subscribe("sgc@dataset@update");
	this.subscribe("sgc@dataset@delete");
  }  
   
  this.unsubscribe_all = function() {
	this.unsubscribe("sgc@dataset@new");
	this.unsubscribe("sgc@dataset@update");
	this.unsubscribe("sgc@dataset@delete");
  }   
  
  var evt_onsgcmessage = new event("onsgcmessage");   
  var evt_onsgcsubscribe = new event("onsgcsubscribe");
  var evt_onsgcunsubscribe = new event("onsgcunsubscribe");   
  var evt_onsgcdataset = new event("onsgcdataset");   
  
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
  	  } else if (obj.result['method'] == "sgc@dataset") {
	    evt_onsgcdataset.fire(
	    {
	      name: 'onsgcdataset',
		  channel: obj.result['channel'],
          dataset: obj.result['dataset']		  
	    }
	    )		
  	  } else if (obj.result['method'] == "sgc@message") {
	    evt_onsgcmessage.fire(
	    {
	      name: 'onsgcmessage',
          message: obj.result['message']		  
	    }
	    )		
	  }
    }
  });  
  
  var on_override = this.on; 
  this.on = function (evtname, fn) {  
    if (evtname == "sgcdataset") {
      evt_onsgcdataset.subscribe(fn);
    } else if (evtname == "sgcmessage") {
      evt_onsgcmessage.subscribe(fn);
    } else if (evtname == "sgcsubscribe") {
      evt_onsgcsubscribe.subscribe(fn);
    } else if (evtname == "sgcunsubscribe") {
      evt_onsgcunsubscribe.subscribe(fn);
    } else {
      on_override.apply(this, arguments); 
  };
  };  

}

sgcws_dataset.prototype = new sgcWebSocket();
sgcws_dataset.prototype.constructor = sgcws_dataset;

