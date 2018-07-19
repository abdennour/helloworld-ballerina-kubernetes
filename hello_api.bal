import ballerina/http;
import ballerina/log;

endpoint http:Listener helloListener {
    port:8888
};

// Yes, you can define many endpoints and bind them with services
endpoint http:Listener myListener {
    port:7070
};

@http:ServiceConfig {
    basePath: "/"
}
service<http:Service> hello bind helloListener {
    sayHello (endpoint caller, http:Request request) {
        http:Response response = new;
        response.setPayload("Hello API from elegance.abdennoor.com!");
        // Ignore errors by using "_"
         _ = caller -> respond(response);
        // To Handle error, uncomment the following instructions
        // caller ->respond(res) but { 
        //     error e => log:printError("Error sending response", err = e)
        // };
    }
}