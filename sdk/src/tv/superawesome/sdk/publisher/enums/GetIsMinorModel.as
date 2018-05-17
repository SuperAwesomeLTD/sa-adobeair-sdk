package tv.superawesome.sdk.publisher.enums {

public class GetIsMinorModel {

    public var country: String;
    public var consentAgeForCountry: int;
    public var age: int;
    public var isMinor: Boolean;

    public function GetIsMinorModel (country: String,
                                     consentAgeForCountry: int,
                                     age: int,
                                     isMinor: Boolean) {
        this.country = country;
        this.consentAgeForCountry = consentAgeForCountry;
        this.age = age;
        this.isMinor = isMinor;
    }
}
}
