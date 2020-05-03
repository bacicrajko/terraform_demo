package acceptance_tests

import (
	"context"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/magiconair/properties/assert"
	"net/http"
	"testing"
	"time"
)

func TestWebApp(t *testing.T){
	t.Parallel()
	//using terraform to apply the setup
	terraformOptions := &terraform.Options{
		TerraformDir: "../dev",
		NoColor:      true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	homepage := terraform.Output(t, terraformOptions, "app_url")
	client := http.Client{
		Timeout: 60 * time.Second,
	}
	var clients *Clients = GetClients()
	response,_ :=client.Get(fmt.Sprintf("http://%s", homepage))
	assert.Equal(t,response.StatusCode, 200)
	webClient := clients.WebClient
	webApp,_ := webClient.Get(context.Background(),"terraform-demo-development", "development-tfdemo-rb")
	assert.Equal(t,webApp.StatusCode, 200)
	servicePlan,_ := clients.AppSvcClient.Get(context.Background(), "terraform-demo-development", "example-appserviceplan")
	assert.Equal(t,servicePlan.StatusCode, 200)
	assert.Equal(t, *servicePlan.Sku.Tier, "Basic")
	assert.Equal(t,*servicePlan.Sku.Size,"B1")
}
