package plugins

import (
	"context"
	"fmt"
	pluginapi "k8s.io/kubelet/pkg/apis/deviceplugin/v1beta1"
)

type TestDevicePlugin struct {
	baseDevicePlugin
}

func NewTestDevicePlugin(config *GPUPluginConfig) (*TestDevicePlugin, error) {
	devices := make([]*pluginapi.Device, 0)
	for i := 0; i < 10; i++ {
		devices = append(devices, &pluginapi.Device{
			ID:     fmt.Sprintf("TEST-%d", i),
			Health: pluginapi.Healthy,
		})
	}

	return &TestDevicePlugin{baseDevicePlugin: baseDevicePlugin{ResourceName: ResourceTest, devices: devices, GPUPluginConfig: config}}, nil
}

func (c *TestDevicePlugin) Allocate(ctx context.Context, request *pluginapi.AllocateRequest) (*pluginapi.AllocateResponse, error) {
	devicesIDs := []string{}
	for _, container := range request.ContainerRequests {
		devicesIDs = append(devicesIDs, container.DevicesIDs...)
	}
	if len(devicesIDs) == 0 {
		return &pluginapi.AllocateResponse{}, fmt.Errorf("devices is empty")
	}

	return &pluginapi.AllocateResponse{
		ContainerResponses: []*pluginapi.ContainerAllocateResponse{
			{
				Envs: map[string]string{
					"MICHALE_MO":      "YES",
					"MICHAEL_MO_TEST": "YES",
				},
			},
		},
	}, nil
}

func (c *TestDevicePlugin) PreStartContainer(ctx context.Context, request *pluginapi.PreStartContainerRequest) (*pluginapi.PreStartContainerResponse, error) {
	return &pluginapi.PreStartContainerResponse{}, nil
}
