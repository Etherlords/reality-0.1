/**
 * author: chaos-encoder
 * Date: 12.02.12 Time: 17:41
 */
package {
import core.services.ServicesLocator;

import org.hamcrest.assertThat;
import org.hamcrest.object.notNullValue;

import ui.services.CameraService;

public class ServicesLocatorTest {


    [Test]
    public function testGetCameraService():void {
        var service:CameraService = new CameraService();
        ServicesLocator.instance.addService(service);
        assertThat(ServicesLocator.instance.getServiceByClass(CameraService), notNullValue());
        assertThat(ServicesLocator.cameraService, notNullValue());

    }

}
}
