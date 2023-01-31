unit JsonRpcConst;

interface

const
  { TCP Const }
  DEFAULT_TCP_PORT = 49500;


  { JSON RPC error codes }
  RPC_PARSE_ERROR = -32700;     // Parse error. 	Invalid JSON. An error occurred on the server while parsing the JSON text.
  RPC_INVALID_REQUEST = -32600; // Invalid Request. 	The received JSON is not a valid JSON-RPC Request.
  RPC_METHOD_NOT_FOUND = -32601;// Method not found. 	The requested remote-procedure does not exist / is not available.
  RPC_INVALID_PARAMS = -32602; 	// Invalid params. 	Invalid method parameters.
  RPC_INTERNAL_ERROR = -32603; 	// Internal error. 	Internal JSON-RPC error.
                                // -32099..-32000 	Server error.


implementation

end.
