package tv.superawesome.Data.Models {
	
	public class SACreative {
		// members
		public var creativeId: int;
		public var name: String;
		public var cpm: int;
		public var impresionURL: String;
		public var clickURL: String;
		public var approved: Boolean;		
		public var format: String;
		public var details: SADetails;
		
		// constructor
		public function SACreative() {
			// do nothing
		}
	}
}