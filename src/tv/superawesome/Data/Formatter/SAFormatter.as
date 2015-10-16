package tv.superawesome.Data.Formatter {
	import flash.utils.ByteArray;
	
	import tv.superawesome.Data.Models.SACreative;
	import tv.superawesome.Data.Models.SACreativeFormat;
	
	public class SAFormatter {
		
		public static function formatCreativeDataIntoAdHTML(creative: SACreative): String {
			
			switch (creative.format) {
				case SACreativeFormat.image_with_link: {
					return formatCreativeIntoImageHTML(creative);
					break;
				}
				case SACreativeFormat.video: {
					return formatCrativeIntoVideoHTML(creative);
					break;
				}
				case SACreativeFormat.rich_media: {
					return formatCreativeIntoRichMediaHTML(creative);
					break;
				}
				case SACreativeFormat.rich_media_resizing: {
					return formatCreativeIntoRichMediaResizingHTML(creative);
					break;
				}
				case SACreativeFormat.swf: {
					return formatCreativeIntoSWFHTML(creative);
					break;
				}
				case SACreativeFormat.tag: {
					return formatCreativeIntoTagHTML(creative);
					break;
				}
				default: {
					break;
				}
			}
			
			return null;
		}
		
		
		private static function formatCreativeIntoImageHTML(creative: SACreative): String {
			[Embed('../../../../resources/displayImage.html', mimeType="application/octet-stream")] var myReferenceFile:Class;
			var bundleFileBytes: ByteArray = new myReferenceFile();
			
			var template: String = bundleFileBytes.toString();
			var value: String = creative.details.image;
			var click: String = creative.clickURL;
			template = template.replace("imageURL", value);
			template = template.replace("hrefURL", click);
			return template;
		}
		
		private static function formatCrativeIntoVideoHTML(creative: SACreative): String {
			[Embed('../../../../resources/displayVideo.html', mimeType="application/octet-stream")] var myReferenceFile:Class;
			var bundleFileBytes: ByteArray = new myReferenceFile();
			
			var template: String = bundleFileBytes.toString();
			var value: String = creative.details.video;
			var click: String = creative.clickURL;
			template = template.replace("videoURL", value);
			template = template.replace("hrefURL", click);
			return template;
		}
		
		private static function formatCreativeIntoRichMediaHTML(creative: SACreative): String {
			[Embed('../../../../resources/displayRichMedia.html', mimeType="application/octet-stream")] var myReferenceFile:Class;
			var bundleFileBytes: ByteArray = new myReferenceFile();
			
			var template: String = bundleFileBytes.toString();
			var value: String = creative.details.url;
			template = template.replace("richMediaURL", value);
			return template;
		}
		
		private static function formatCreativeIntoRichMediaResizingHTML(creative: SACreative): String {
			[Embed('../../../../resources/displayRichMedia.html', mimeType="application/octet-stream")] var myReferenceFile:Class;
			var bundleFileBytes: ByteArray = new myReferenceFile();
			
			var template: String = bundleFileBytes.toString();
			var value: String = creative.details.url;
			template = template.replace("richMediaURL", value);
			return template;
		}
		
		private static function formatCreativeIntoSWFHTML(creative: SACreative): String {
			return "";
		}
		
		private static function formatCreativeIntoTagHTML(creative: SACreative): String {
			[Embed('../../../../resources/displayTag.html', mimeType="application/octet-stream")] var myReferenceFile:Class;
			var bundleFileBytes: ByteArray = new myReferenceFile();
			
			var template: String = bundleFileBytes.toString();
			var value: String = creative.details.tag;
			value = getSubString("src=\"","\"",value);
			template = template.replace("richMediaURL", value);
			return template;
		}
		
		// aux function
		private static function getSubString(start:String, end:String, fullString:String):String {
			var startIndex:Number = fullString.indexOf(start) + start.length;
			var endIndex:Number = fullString.indexOf(end) - 1;
			return fullString.substring(startIndex, endIndex);
		}
	}	
}