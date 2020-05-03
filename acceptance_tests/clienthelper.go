package acceptance_tests
import (
	"github.com/Azure/azure-sdk-for-go/profiles/2019-03-01/web/mgmt/web"
	"github.com/Azure/go-autorest/autorest/azure/auth"
	"os"
)
type Clients struct {
	WebClient web.AppsClient
	AppSvcClient web.AppServicePlansClient
}

func GetClients() (*Clients){
	subscriptionId,clientId,clientSecret,tenantId := os.Getenv("ARM_SUBSCRIPTION_ID"),os.Getenv("ARM_CLIENT_ID"),os.Getenv("ARM_CLIENT_SECRET"),os.Getenv("ARM_TENANT_ID")
	credentialsAuth := auth.NewClientCredentialsConfig(clientId, clientSecret,tenantId)
	client := web.NewAppsClient(subscriptionId)
	appclient := web.NewAppServicePlansClient(subscriptionId)
	client.Authorizer,_ = credentialsAuth.Authorizer()
	appclient.Authorizer,_=credentialsAuth.Authorizer()
	return &Clients{
		WebClient:    client,
		AppSvcClient: appclient,
	}
}
