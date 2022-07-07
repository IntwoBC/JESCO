report 50102 "Jesco Sales-Proforma Invoice"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\JescoSalesProformaInvoice.rdl';

    dataset
    {
        dataitem("Sales Header";
        "Sales Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Invoice';
            CalcFields = Amount, "Amount Including VAT";

            //**********************Customer Details*************************
            column(Cust_Name; Cust.Name) { }
            column(Page_Lbl; PageLbl) { }
            column(Cust_add1; Cust.Address) { }
            column(Cust_add2; Cust."Address 2") { }
            column(Cust_Post_Code; Cust."Post Code") { }
            column(Cust_Country; CountryRegion.Name) { } //Cust."Country/Region Code") { }
            column(Cust_VatRegNo; Cust."VAT Registration No.") { }
            //**********************Customer Details*************************
            //**********************Header Details*************************
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            column(External_Document_No_; "External Document No.") { }
            column(Order_No_; "Prepayment No.") { }
            column(Order_Date; "Order Date") { }
            column(LPO_Date; "LPO Date") { }
            //**********************Header Details*************************
            //**********************Footer Details*************************
            column(CompInfo_Name; CompanyInfo.Name) { }
            column(CompInfoAdd1; CompanyInfo.Address) { }
            column(CompInfo_Postcode; CompanyInfo."Post Code") { }
            column(Comp_add2; CompanyInfo."Address 2") { }
            column(CompInfo_city; CompanyInfo.City) { }
            column(CompInfo_Coountry; CompanyInfo."Country/Region Code") { }
            column(CompInfo_Phone; CompanyInfo."Phone No.") { }
            column(CompInfo_Fax; CompanyInfo."Fax No.") { }
            column(CompInfo_Email; CompanyInfo."E-Mail") { }
            column(CompInfo_Home; CompanyInfo."Home Page") { }
            column(CompInfo_Picture; CompanyInfo.Picture) { }
            //**********************Footer Details*************************
            column(Currency_Code; "Currency Code") { }
            column(Payment_Method_Code; "Payment Method Code") { }
            column(Shipment_Method_Code; TransportMethodG.Description) { } //ShipmentMethodG.Description) { }
            column(User_ID; UserId) { }
            column(TotalVATAmountInWords; TotalVATAmountInWords) { }
            column(TotalAmountInWords; TotalAmountInWords) { }
            column(Payment_Terms_Code; PaymentTerms.Description) { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }
            column(Bill_to_Post_Code; "Bill-to Post Code") { }
            column(Prepayment__; "Prepayment %") { }
            column(PrepaymentVATAmount; PrepaymentVATAmount) { }
            column(PrepaymentTotalAmount; PrepaymentTotalAmount) { }
            column(Bill_to_Country_Region_Code; "Bill-to Country/Region Code") { }
            column(BankDetailsAvailable; BankDetailsAvailable) { }
            column(BankAccNumber; BankDetails[1]) { }
            column(BankAccName; BankDetails[2]) { }
            column(BankContact; BankDetails[3]) { }
            column(BankAddress; BankDetails[4]) { }
            column(BankSwift; BankDetails[5]) { }
            column(BankIban; BankDetails[6]) { }
            column(ShowTitle; ShowTitle) { }
            column(CommercialInvoice; CommercialInvoice) { }
            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(SrNo; SrNo) { }
                column(Type_LineNumber; Format(Type.AsInteger())) { }
                column(Quantity; Quantity) { }
                column(Description; Description) { }
                column(Unit_Price; "Unit Price") { }
                column(Line_Amount; "Line Amount") { }
                column(VAT__; "VAT %") { }
                column(Line_Discount_Amount; "Inv. Discount Amount") { } //"Line Discount Amount") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(Taxpayable; Taxpayable) { }
                column(Amt; Amt) { }
                trigger OnAfterGetRecord()
                begin
                    Clear(Taxpayable);
                    Clear(Amt);
                    if Type <> Type::" " then
                        SrNo += 1;
                    Amt := Quantity * "Unit Price";
                    Taxpayable := "Amount Including VAT" - Amount;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(TotalVatAmt);
                Clear(ShipmentMethodG);
                SrNo := 0;
                if Cust.Get("Sell-to Customer No.") then;
                if ShipmentMethodG.Get("Shipment Method Code") then;
                if TransportMethodG.Get("Sales Header"."Transport Method") then;
                TotalVatAmt := "Amount Including VAT" - Amount;
                if "Prepayment %" = 0 then begin

                    if TotalVatAmt <> 0 then begin
                        Clear(DecimalValue);
                        Clear(DecimalValueInWords);
                        DecimalValue := ROUND(TotalVatAmt) MOD 1 * 100;
                        MyAmountInWords.InitTextVariable();
                        MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                        IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                        MyAmountInWords.FormatNoText(TotalVATAmountWords, TotalVatAmt, '');
                        TotalVATAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                    end;
                    CalcFields("Amount Including VAT");
                    if "Amount Including VAT" <> 0 then begin
                        Clear(DecimalValue);
                        Clear(DecimalValueInWords);
                        DecimalValue := ROUND("Amount Including VAT") MOD 1 * 100;
                        MyAmountInWords.InitTextVariable();
                        MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                        IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                        MyAmountInWords.FormatNoText(TotalVATAmountWords, "Amount Including VAT", '');
                        TotalAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                    end;
                end else begin
                    PrepaymentVATAmount := 0;
                    PrepaymentVATAmount := TotalVatAmt * "Prepayment %" / 100;
                    if PrepaymentVATAmount <> 0 then begin
                        Clear(DecimalValue);
                        Clear(DecimalValueInWords);
                        DecimalValue := ROUND(PrepaymentVATAmount) MOD 1 * 100;
                        MyAmountInWords.InitTextVariable();
                        MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                        IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                        MyAmountInWords.FormatNoText(TotalVATAmountWords, PrepaymentVATAmount, '');
                        TotalVATAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                    end;
                    CalcFields("Amount Including VAT");
                    PrepaymentTotalAmount := 0;
                    PrepaymentTotalAmount := "Amount Including VAT" * "Prepayment %" / 100;
                    if PrepaymentTotalAmount <> 0 then begin
                        Clear(DecimalValue);
                        Clear(DecimalValueInWords);
                        DecimalValue := ROUND(PrepaymentTotalAmount) MOD 1 * 100;
                        MyAmountInWords.InitTextVariable();
                        MyAmountInWords.FormatNoText(DecimalValueInWords, DecimalValue, '');
                        IF DecimalValueInWords[1] = '' THEN DecimalValueInWords[1] := 'ZERO';
                        MyAmountInWords.FormatNoText(TotalVATAmountWords, PrepaymentTotalAmount, '');
                        TotalAmountInWords := TotalVATAmountWords[1] + ' AND ' + DecimalValueInWords[1] + ' ONLY';
                    end;

                end;
                BankDetailsAvailable := false;
                if "Direct Debit Mandate ID" <> '' then begin
                    BankDetailsAvailable := true;
                    if SepaDirectDebt.GET("Direct Debit Mandate ID") then begin
                        if CustBankAcc.GET("Sell-to Customer No.", SepaDirectDebt."Customer Bank Account Code") then begin
                            BankDetails[1] := CustBankAcc.Code;
                            BankDetails[2] := CustBankAcc.Name;
                            BankDetails[3] := CustBankAcc.Contact;
                            BankDetails[4] := CustBankAcc.Address + ' ' + CustBankAcc."Address 2";
                            BankDetails[5] := CustBankAcc."SWIFT Code";
                            BankDetails[6] := CustBankAcc.IBAN;
                        end;
                    end;
                end;
                if PaymentTerms.Get("Sales Header"."Payment Terms Code") then;
                Clear(CountryRegion);
                if CountryRegion.Get(Cust."Country/Region Code") then;
            end;

            trigger OnPreDataItem()
            begin
                if CommercialInvoice then
                    ShowTitle := 'Commercial Invoice'
                else
                    ShowTitle := 'Proforma Invoice';
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(CommercialInvoice; CommercialInvoice)
                    {
                        ApplicationArea = All;
                        Caption = 'Commercial Invoice';
                    }
                }
            }
        }
    }
    labels
    {
        TaxInvLbl = 'TAX INVOICE';
        CustLbl = 'Customer :';
        PoBoxLbl = 'Po Box -';
        TRNLbl = 'TRN :';
        SlnoLbl = 'SL No';
        TRLbl = 'TRN';
        TaxInvnoLbl = 'Invoice No';
        DateofInvLbl = 'Date of Invoice';
        DateofSuppLbl = 'Date of Supply';
        JobLbl = 'Job No';
        LpoRefLbl = 'LPO Ref No';
        LpoDateLbl = 'LPO Date';
        DNLbl = 'DN No';
        MRFLbl = 'MRF No';
        PreparedLbl = 'Prepared By';
        TotalAmtInLbl = 'TOTAL AMOUNT IN AED';
        BankDetailsLbl = 'Bank Details';
        HeadOffLbl = 'Head Office';
        Officelbl = 'Office no:';
        POlbl = 'P.O. Box:';
        PhnoneLbl = 'Phone:';
        FaxLbl = 'Fax:';
        EmailLbl = 'E-mail:';
        Weblbl = 'Web:';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get;
    end;

    var
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        MyAmountInWords: Report "My Amount In Words";
        TotalVatAmt: Decimal;
        DecimalValue: Decimal;
        DecimalValueInWords: ARRAY[2] OF Text;
        TotalVATAmountWords: ARRAY[2] OF Text;
        TotalAmountInclVATWords: ARRAY[2] OF Text;
        TotalVATAmountInWords: Text;
        TotalAmountInWords: Text;
        Taxpayable: Decimal;
        Amt: Decimal;
        SrNo: Integer;
        ShipmentMethodG: Record "Shipment Method";
        TransportMethodG: Record "Transport Method";
        CommercialInvoice: Boolean;
        ShowTitle: Text;
        PageLbl: Label 'Page';
        CurrencyText: Text;
        PrepaymentVATAmount: Decimal;
        PrepaymentTotalAmount: Decimal;
        BankDetails: array[6] of Text[50];
        BankDetailsAvailable: Boolean;
        SepaDirectDebt: Record "SEPA Direct Debit Mandate";
        CustBankAcc: Record "Customer Bank Account";
        PaymentTerms: Record "Payment Terms";
        CountryRegion: Record "Country/Region";

}
