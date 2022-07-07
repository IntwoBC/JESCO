report 50108 "Purchase Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\PurchaseOrder.rdl';
    Caption = 'Purchase Order';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'Purchase Order';
            column(CompanyInfo_Pic; CompanyInfo.Picture) { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(Buy_from_Address; "Buy-from Address") { }
            column(Buy_from_Address_2; "Buy-from Address 2") { }
            column(Buy_from_City; "Buy-from City") { }
            column(Buy_from_Post_Code; "Buy-from Post Code") { }
            column(Buy_from_Country_Region_Code; CountryRegion.Name) { }
            column(Buy_from_Contact; "Buy-from Contact") { }
            column(No_Header; "No.") { }
            column(Document_Date; Format("Purchase Header"."Document Date", 0, 4)) { }
            column(Payment_Terms_Code; PaymentTerms.Description) { }
            column(Shipment_Method_Code; ShipmentMethod.Description) { }
            column(Your_Reference; "Your Reference") { }
            column(VATAmount; VATAmount) { }
            column(TotalAmountInclVAT; TotalAmountInclVAT) { }
            column(Lead_Time_Calculation; LeadTimeCalculation) { }
            column(Transport_Method; TransportMethod.Description) { }
            column(Name; Name) { }
            column(Addr1; Addr1) { }
            column(Addr2; Addr2) { }
            column(City; City) { }
            column(PostCode; PostCode) { }
            column(Region; Region) { }
            column(Ph; Ph) { }
            column(Homepage; Homepage) { }
            column(Email; Email) { }
            column(VatRegNo; VatRegNo) { }
            column(Document_Required; "Document Required") { }
            column(WorkDescG; WorkDescG) { }
            column(TotalInvDiscAmt; TotalInvDiscAmt) { }
            column(TotalCaption; TotalCaption) { }
            column(Vendor_Order_No_; "Vendor Order No.") { }
            column(TotalAmountInWords; TotalAmountInWords) { }
            column(NoofArchVer; "No. of Archived Versions") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purchase Header";
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                column(Type_Line; PurchInLineTypeNo) { }
                column(No_Line; "No.") { }
                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(Line_Discount__; "Line Discount %") { }
                column(Line_Amount; "Line Amount") { }
                column(TotalInclVATText; TotalInclVATText) { }
                column(VATAmountText; VATAmountLine.VATAmountText) { }
                column(TotalSubTotal; TotalSubTotal) { }
                column(SLNo; SLNo) { }
                column(SearchName; SearchName) { }
                column(Cross_Reference_No_; "Item Reference No.") { }

                trigger OnAfterGetRecord()
                var
                    RecItemL: Record Item;
                begin
                    PurchInLineTypeNo := Type.AsInteger();
                    TotalSubTotal += "Line Amount";
                    if not (Type = Type::" ") then
                        SLNo += 1;
                    Clear(SearchName);
                    if Type = Type::Item then begin
                        if RecItemL.GET("No.") then
                            SearchName := RecItemL."Search Description";
                    end

                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Clear(PurchLine);
                Clear(PurchPost);
                Clear(WorkDescG);
                PurchLine.DeleteAll();
                VATAmountLine.DeleteAll();
                CalcFields("No. of Archived Versions");
                PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                VATAmount := VATAmountLine.GetTotalVATAmount;
                VATBaseAmount := VATAmountLine.GetTotalVATBase;
                VATDiscountAmount :=
                  VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;
                TotalInvDiscAmt := VATAmountLine.GetTotalInvDiscAmount();
                FormatDocumentFields("Purchase Header");

                Clear(PaymentTerms);
                Clear(ShipmentMethod);
                if PaymentTerms.Get("Payment Terms Code") then;
                if ShipmentMethod.Get("Shipment Method Code") then;
                Clear(CountryRegion);
                if CountryRegion.Get("Purchase Header"."Buy-from Country/Region Code") then;
                Clear(TransportMethod);
                if TransportMethod.Get("Purchase Header"."Transport Method") then;

                //Ship-to Address
                if "Purchase Header"."Ship-to Name" <> '' then
                    if "Purchase Header"."Sell-to Customer No." <> '' then
                        if customer.Get("Purchase Header"."Sell-to Customer No.") then begin
                            FillShiptoAddressDetails(Name, customer.Address, customer."Address 2", customer.City, customer."Post Code", customer."Country/Region Code", customer."Phone No.", customer."Home Page", customer."E-Mail", "VAT Registration No.");
                        end;
                if "Purchase Header"."Ship-to Name" <> '' then
                    if "Purchase Header"."Location Code" <> '' then
                        if Location.Get("Purchase Header"."Location Code") then begin
                            FillShiptoAddressDetails(Name, Location.Address, Location."Address 2", Location.City, Location."Post Code", Location."Country/Region Code", Location."Phone No.", Location."Home Page", Location."E-Mail", "VAT Registration No.");
                        end;
                if "Purchase Header"."Ship-to Name" = '' then begin
                    FillShiptoAddressDetails(Name, customer.Address, customer."Address 2", customer.City, customer."Post Code", customer."Country/Region Code", customer."Phone No.", customer."Home Page", customer."E-Mail", "VAT Registration No.");
                end;

                Clear(CheckLeadTime);
                CheckLeadTime := Format("Purchase Header"."Lead Time Calculation");
                if CheckLeadTime <> '' then begin
                    CheckLeadTime := CopyStr(Format("Purchase Header"."Lead Time Calculation"), StrLen(Format("Purchase Header"."Lead Time Calculation")));
                    LeadTimeCalculation := CopyStr(Format("Purchase Header"."Lead Time Calculation"), 1, StrLen(Format("Purchase Header"."Lead Time Calculation")) - 1);
                    case CheckLeadTime of
                        'D':
                            LeadTimeCalculation := LeadTimeCalculation + ' ' + 'Days';
                        'W':
                            LeadTimeCalculation := LeadTimeCalculation + ' ' + 'Weeks';
                        'Y':
                            LeadTimeCalculation := LeadTimeCalculation + ' ' + 'Years';
                    end;
                end;
                WorkDescG := GetWorkDescription();

                if "Purchase Header"."Currency Code" = '' then
                    TotalCaption := 'Total' + ' ' + Format(GLSetup."LCY Code")
                else
                    TotalCaption := 'Total' + ' ' + Format("Purchase Header"."Currency Code");


                if TotalAmountInclVAT <> 0 then begin
                    Clear(DecimalValue);
                    Clear(DecimalValueInWords);
                    DecimalValue := ROUND(TotalAmountInclVAT) MOD 1 * 100;
                    MyAmountInWords.InitTextVariable();
                    MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                    IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                    MyAmountInWords.FormatNoText(TotalVATAmountWords, TotalAmountInclVAT, '');
                    TotalAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                end;
            end;
        }
    }
    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        FormatDocument: Codeunit "Format Document";
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        PurchPost: Codeunit "Purch.-Post";
        PurchLine: Record "Purchase Line" temporary;
        VATAmountLine: Record "VAT Amount Line" temporary;
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        CountryRegion: Record "Country/Region";
        TransportMethod: Record "Transport Method";
        Name: Text;
        Addr1: Text;
        Addr2: Text;
        City: Text;
        PostCode: Text;
        Region: Text;
        Ph: Text;
        Homepage: Text;
        Email: Text;
        VatRegNo: Text;
        customer: Record Customer;
        Location: Record Location;
        LeadTimeCalculation: Text;
        CheckLeadTime: Text;
        WorkDescG: Text;
        TotalSubTotal: Decimal;
        PurchInLineTypeNo: Integer;
        TotalInvDiscAmt: Decimal;
        TotalCaption: Text;
        SLNo: Integer;
        MyAmountInWords: Report "My Amount In Words";
        DecimalValue: Decimal;
        DecimalValueInWords: ARRAY[2] OF Text;
        TotalVATAmountWords: ARRAY[2] OF Text;
        TotalAmountInWords: Text;
        SearchName: Text;

    local procedure FormatDocumentFields(PurchaseHeader: Record "Purchase Header")
    begin
        FormatDocument.SetTotalLabels(PurchaseHeader."Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
    end;

    local procedure FillShiptoAddressDetails(NameP: Text; Addr1P: Text; Addr2P: Text; CityP: Text; PostCodeP: Text; RegionP: Text; PhP: Text; HomepageP: Text; EmailP: Text; VatRegNoP: Text)
    var
        CountryRegionL: Record "Country/Region";
    begin
        Name := NameP;
        Addr1 := Addr1P;
        Addr2 := Addr2P;
        City := CityP;
        PostCode := PostCodeP;
        if CountryRegionL.Get(RegionP) then
            Region := CountryRegionL.Name;
        Ph := PhP;
        Homepage := HomepageP;
        Email := EmailP;
        VatRegNo := VatRegNoP;
    end;

}
