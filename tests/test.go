package test

import (
	"context"
	"testing"

	"github.com/Azure/azure-sdk-for-go/profiles/2019-03-01/web/mgmt/web"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

//TestServicePlan acceptance test of
func TestServicePlan(t *testing.T) {
	t.Parallel()
	//using terraform to apply the setup
	terraformOptions := &terraform.Options{
		TerraformDir: "../dev",
		NoColor:      true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
	//but using azure provider to test the setup
	client := web.NewAppsClient("asdsdasasds")
	webApp, _ := client.Get(context.TODO(), "resorcegroupname", "appname")
}
