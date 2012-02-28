package  demo
{

	import org.flexunit.Assert;

	public class SampleTest
	{
		
		public function SampleTest() 
		{
			super();
		}

		[Test(description="Sample sucess test")]
		public function testSuccess():void
		{
			
		}

		[Test]
		public function testSampleFailure() : void 
		{
			//Assert.fail("FAIL! - This is a sample test that will fail.");
		}
		
		[Test(expects="Error")]
		public function testSampleExpectError() : void 
		{
			throw new Error("ERROR! - This is an error");
		}

		[Test]
		public function testSampleError() : void 
		{
			//throw new Error("ERROR! - This is an error");
		}

		[Ignore]
		[Test]
		public function testSampleIgnore() : void 
		{

		}
	}
}