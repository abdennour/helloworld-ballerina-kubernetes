import ballerina/http;
import ballerina/log;
import ballerinax/kubernetes;


@kubernetes:Service {
    serviceType: "NodePort",
    name: "ballerina-demo"

}
endpoint http:Listener helloListener {
    port:8888
};

@kubernetes:Deployment {
    enableLiveness: true,
    image: "abdennour/ballerina-demo",
    name: "ballerina-demo"
}
@http:ServiceConfig {
    basePath: "/"
}
service<http:Service> hello bind helloListener {
    sayHello (endpoint caller, http:Request request) {
        http:Response response = new;
        response.setPayload("Hello Kubernetes from elegance.abdennoor.com!");
         _ = caller -> respond(response);
    }
}