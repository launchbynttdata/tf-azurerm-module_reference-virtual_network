package common

import (
	"testing"

	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)


func TestComposableVnet(t *testing.T, ctx types.TestContext) {
		// TODO: Remove this test from your module once you have defined some other tests.
	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		assert.Equal(t, "foo", "foo", "Should always be the same!")
		assert.NotEqual(t, "foo", "bar", "Should never be the same!")
	})

	// TODO: Uncomment test code provided below when tests below are fixed as per new variable structure.
	// subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	// if len(subscriptionId) == 0 {
	// 	t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	// }

	// vnetIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "vnet_ids")
	// vnetNames := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "vnet_names")
	// rgIds := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "rg_ids")
	// rgNames := terraform.OutputMap(t, ctx.TerratestTerraformOptions(), "rg_names")
	// subnetMap := terraform.OutputMapOfObjects(t, ctx.TerratestTerraformOptions(), "vnet_subnet_name_id_map")

	// for name, vnetName := range vnetNames {
	// 	t.Run("VnetExists_"+vnetName, func(t *testing.T) {
	// 		assert.True(t, azure.VirtualNetworkExists(t, vnetName, rgNames[name], subscriptionId), "Virtual Network must exist")
	// 	})
	// }

	// for _, rgName := range rgNames {
	// 	t.Run("RgExists_"+rgName, func(t *testing.T) {
	// 		assert.True(t, azure.ResourceGroupExists(t, rgName, subscriptionId), "Resource Group must exist")
	// 	})
	// }

	// for name, s := range subnetMap {
	// 	for subnetName := range s.(map[string]interface{}) {
	// 		t.Run("SubnetExists_"+subnetName, func(t *testing.T) {
	// 			assert.True(t, azure.SubnetExists(t, subnetName, vnetNames[name], rgNames[name], subscriptionId), "Subnet must exist")
	// 		})
	// 	}
	// }

	// t.Run("ValidateTerraformOutputs", func(t *testing.T) {
	// 	assert.NotEmpty(t, vnetIds, "VNet ID must not be empty")
	// 	assert.NotEmpty(t, rgIds, "Resource Group ID must not be empty")
	// })
}
