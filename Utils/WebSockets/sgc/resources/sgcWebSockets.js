/*
**************************************************************************
 sgcWebSocket component

 written by eSeGeCe
            copyright © 2013
            Email : info@esegece.com
            Web : http://www.esegece.com
**************************************************************************
*/

function GUID ()
{
    var S4 = function ()
    {
        return Math.floor(
                Math.random() * 0x10000
            ).toString(16);
    };

    return (
            S4() + S4() + 
            S4() + 
            S4() + 
            S4() + 
            S4() + S4() + S4()
        );
}

function event(name) {
  this.name = name;
  //function to call on event fire
  this.eventAction = null;
  //subscribe a function to the event
  this.subscribe = function(fn) {
    this.eventAction = fn;
  };
  //fire the event
  this.fire = function(sender, eventArgs) {
    if(this.eventAction != null) {
      this.eventAction(sender, eventArgs);
    };
  };
}

function sgcWebSocket() {  
  if (arguments.length == 0) return;
  
  if ("WebSocket" in window) {  
  
    // ... decode constructor arguments	
    if (typeof arguments[0] == "object") {
      this.host = arguments[0]["host"]; 
	  this.subprotocol = arguments[0]["subprotocol"];
      this.user = arguments[0]["user"]; 
	  this.password = arguments[0]["password"];	  
	} else if (typeof arguments[0] == "string") {  
	  this.host = arguments[0];
	  if (arguments.length == 2) {
	    this.subprotocol = arguments[1];
	  }
	} else {
	  return;
	}

	var evt_onopen = new event("onopen");
	var evt_onclose = new event("onclose");
	var evt_onmessage = new event("onmessage");
	var evt_onstream = new event("onstream");
	var evt_onerror = new event("onerror");
	
    this.open = function () {   
      if ((this.host !== "") && (this.user !== "") && (this.user !== undefined)) {
	    if (this.password == undefined) {
		  this.password == "";
		}		
		if ((this.subprotocol !== "") && (this.subprotocol !== undefined)) {
		  this.websocket = new WebSocket(this.host + "/sgc/auth/basic/" + this.user + "/" + this.password, this.subprotocol);
		} else {
		  this.websocket = new WebSocket(this.host + "/sgc/auth/basic/" + this.user + "/" + this.password);		
		}	    
	  } else if ((this.host !== "") && (this.subprotocol !== "") && (this.subprotocol !== undefined)) {
	    this.websocket = new WebSocket(this.host, this.subprotocol);
	  } else if (this.host !== "") {  
	    this.websocket = new WebSocket(this.host);
	  }
	  
	  this.websocket.onopen = function() { 
	    evt_onopen.fire(
		{ 
		  name: 'onopen',
		  message: ''
		});	   
	  }; 

	  this.websocket.onmessage = function(evt) { 
		if (evt.data instanceof Blob) {
			evt_onstream.fire(
			{ 
			  name: 'onstream',
			  stream: evt.data
			});			
		} else {
			evt_onmessage.fire(
			{ 
			  name: 'onmessage',
			  message: evt.data
			});
		}
	  };	  
	  
	  this.websocket.onclose = function(evt) { 
	    evt_onclose.fire(
		{ 
		  name: 'onclose',
		  message: '',
		  code: evt.code,
		  reason: evt.reason,
		  clean: evt.wasClean
		});	   
	  }; 	

	  this.websocket.onerror = function(evt) { 
	    evt_onerror.fire(
		{ 
		  name: 'onerror',
		  message: evt.data
		});	   
	  };
    }     
	
    if (this.websocket == undefined) {
      this.open();
    };	
	
	this.send = function(message) {
	  this.websocket.send(message);
	}
	
	this.close = function () {
	  this.websocket.close();     
	};
	
	this.state = function () {
		switch (this.websocket.readyState) {
		  case this.websocket.CONNECTING:
			return "connecting";
			break;
		  case this.websocket.OPEN:
			return "open";
			break;
		  case this.websocket.CLOSING:
			return "closing";
			break;
		  case this.websocket.CLOSED:
			return "closed";
			break;
		  default:
			return "undefined";
			break;
		}
	}	
	
	this.on = function (evtname, fn) {
	  if (evtname == "open") {
	    evt_onopen.subscribe(fn);
	  } 
	  else if (evtname == "close") {
	    evt_onclose.subscribe(fn);
	  }
	  else if (evtname == "message") {
	    evt_onmessage.subscribe(fn);
	  }	
	  else if (evtname == "stream") {
	    evt_onstream.subscribe(fn);
	  }		  
	  else if (evtname == "error") {
	    evt_onerror.subscribe(fn);
	  }	
	}
  } else {    
    alert("WebSockets not supported by your Browser.");   
  }
}

