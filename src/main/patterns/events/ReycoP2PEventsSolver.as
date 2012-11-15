package patterns.events 
{
	import com.reyco1.multiuser.events.ChatMessageEvent;
	import com.reyco1.multiuser.events.UserStatusEvent;
	import core.net.model.ChatCommandModel;
	import core.net.model.DataModel;
	import core.net.model.UserModel;
	import core.net.model.UserStatusCommandModel;
	import utils.getClassOfObject;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	import patterns.strategy.StrategyController;
	
	/**
	 * ...
	 * @author Nikro
	 */
	public class ReycoP2PEventsSolver extends AbstractEventSolver 
	{
		
		public function ReycoP2PEventsSolver() 
		{
			
			super(new StrategyController());
			
			initilize();
		}
		
		private function initilize():void 
		{
			strategyController.crateNewStrategy(UserStatusEvent, solveUserStatusEvent);
			strategyController.crateNewStrategy(ChatMessageEvent, solveChatMessage);
			
			solver = solveFunction;
		}
		
		private function solveFunction(e:Event):DataModel
		{
			var data:DataModel = strategyController.execute(getClassOfObject(e), e);
			return data
		}
		
		private function solveUserStatusEvent(e:UserStatusEvent):DataModel
		{
			var userData:UserModel = new UserModel(e.user.id, e.user.name);
			var userStatusCommandModel:UserStatusCommandModel = new UserStatusCommandModel(userData, e.type);
			
			return userStatusCommandModel;
		}
		
		private function solveChatMessage(e:ChatMessageEvent):DataModel
		{
			
			var userData:UserModel = new UserModel(e.message.sender, e.message.user);
			var chatCommandModel:ChatCommandModel = new ChatCommandModel(userData, e.message.text);
			
			return chatCommandModel;
		}
		
	}

}