report 50105 "Jesco Sales - Project"
{
    RDLCLayout = '.\Layout Reports Rdls\JescoSalesProject.rdl';
    Caption = 'Project Sales - Quote';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Sales Quote';
            column(Page_Lbl; PageLbl) { }
            column(CompanyAddress1; CompanyAddr[1]) { }
            column(CompanyAddress2; CompanyAddr[2]) { }
            column(CompanyAddress3; CompanyAddr[3]) { }
            column(CompanyAddress4; CompanyAddr[4]) { }
            column(CompanyAddress5; CompanyAddr[5]) { }
            column(CompanyAddress6; CompanyAddr[6]) { }
            column(CompanyAddress7; CompanyAddr[7]) { }
            column(CompanyAddress8; CompanyAddr[8]) { }
            column(CompanyAddress9; CompanyAddr[9]) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice) { }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl) { }
            column(CompanyLegalStatement; GetLegalStatement) { }
            column(CustomerAddress1; CustAddr[1]) { }
            column(CustomerAddress2; CustAddr[2]) { }
            column(CustomerAddress3; CustAddr[3]) { }
            column(CustomerAddress4; CustAddr[4]) { }
            column(CustomerAddress5; CustAddr[5]) { }
            column(CustomerAddress6; CustAddr[6]) { }
            column(CustomerAddress7; CustAddr[7]) { }
            column(CustomerAddress8; CustAddr[8]) { }
            column(CustomerAddress9; CustAddr[9]) { }
            column(CustomerAddress10; CustAddr[10]) { }
            column(DocumentTitle_Lbl; SalesConfirmationLbl) { }
            column(DocumentNo; "No.") { }
            column(NoofArchVer; "No. of Archived Versions") { }
            column(DocumentDate; Format("Document Date", 0, 4)) { }
            column(UserName; UserSetUp."User ID") { } //User."Full Name") { }
            //column(UserMail; User."Authentication Email") { }
            column(SalesPersonName; SalespersonPurchaser.Name) { }
            column(SalespersonPh; SalespersonPurchaser."Phone No.") { }
            column(SalespersonEmail; SalespersonPurchaser."E-Mail") { }
            column(YourReference; "Your Reference 1") { }
            column(YourReference__Lbl; FieldCaption("Your Reference")) { }
            column(QuoteValidToDate; ValidUptoG) { } //Format("Quote Valid Until Date", 0, 4)){}
            column(QuoteValidToDate_Lbl; QuoteValidToDateLbl) { }
            column(DeliveryTimesG; DeliveryTimesG) { }
            column(ShipmentMethodDescription; TransportMethod.Description) { }// ShipmentMethod.Description) { }
            column(PaymentTermsDescription; PaymentTerms.Description) { }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl) { }
            column(ItemNoVisible; ItemNoVisible) { }
            column(WorkDescriptionG; WorkDescriptionG) { }
            column(Subtotal_Lbl; SubtotalLbl) { }
            column(Total_Lbl; TotalLbl) { }
            column(VATAmount_Lbl; VATAmtLbl) { }

            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = Header;
                DataItemTableView = SORTING("Document No.", "Line No.");
                UseTemporary = true;

                column(LineNo_Line; "Line No.") { }
                column(Description_Line; Description) { }
                column(Description_Line_Lbl; FieldCaption(Description)) { }
                column(LineAmount_Line; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(ItemNo_Line; "No.") { }
                column(Quantity_Line; FormattedQuantity) { }
                column(Quantity_Line_Lbl; FieldCaption(Quantity)) { }
                column(Type_Line; Format(Type)) { }
                column(UnitPrice; FormattedUnitPrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(UnitPrice_Lbl; FieldCaption("Unit Price")) { }
                column(UnitOfMeasure; "Unit of Measure") { }
                column(UnitOfMeasure_Lbl; FieldCaption("Unit of Measure")) { }
                column(VATPct_Line; FormattedVATPct) { }
                column(VATPct_Line_Lbl; FieldCaption("VAT %")) { }
                column(SLNo; SLNo) { }
                //column(TotalIncludingVATText; TotalInclVATText) { }
                column(TotalSubTotal; TotalSubTotal)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalVATAmount; TotalAmountVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                {
                    AutoFormatExpression = Header."Currency Code";
                    AutoFormatType = 1;
                }
                column(SerialChar; SerialChar) { }
                column(PrefixValue; PrefixValue) { }
                column(AlternatValue; AlternatValue) { }
                //31-03-2021
                dataitem("BOM Component"; "BOM Component")
                {
                    DataItemLink = "Parent Item No." = FIELD("No.");
                    column(BOMDescription; Description)
                    {
                    }
                    column(Parent_Item_No_; "Parent Item No.")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                    end;
                }
                //31-03-2021
                column(Line_Discount__; "Line Discount %") { }
                column(GLDiscountAmt; GLDiscountAmt) { }
                column(TotalIncludingVATText; TotalCaption) { } //TotalInclVATText) { }

                trigger OnAfterGetRecord()
                var
                    InvDisAmtL: Decimal;
                    ItemL: Record Item;
                    ResourceL: Record Resource;
                begin
                    Clear(ItemL);
                    Clear(ResourceL);
                    if ItemL.Get("No.") then;
                    if ResourceL.Get("No.") then;

                    PrefixValue := false;
                    // if Type IN [Type::Item, Type::"G/L Account", Type::Resource] then begin
                    //     if (ItemL."Duplicate Item") or (ResourceL."Duplicate Item") then begin
                    //         SerialChar := 'A';
                    //         PrefixValue := true;
                    //     end else
                    //         SLNo += 1;
                    // end;

                    if Type IN [Type::"Charge (Item)", Type::"G/L Account"] then
                        SLNo += 1;

                    GLDiscountAmt += "Inv. Disc. Amount to Invoice";

                    if Type = Type::"G/L Account" then begin
                        "No." := '';
                        GLDiscountAmt += Line."Line Discount Amount"
                    end;

                    // PrefixValue := false;
                    // if (ItemL."Duplicate Item") or (ResourceL."Duplicate Item") then begin
                    //     SerialChar := 'A';
                    //     PrefixValue := true;
                    // end;

                    Clear(FormattedLineAmount);
                    FormatDocument.SetSalesLine(Line, FormattedQuantity, FormattedUnitPrice, FormattedVATPct, FormattedLineAmount);

                    Clear(AlternatValue);
                    if Type = Type::Item then
                        if not ItemL."Duplicate Item" then begin
                            SLNo += 1;
                            TotalSubTotal += "Line Amount";
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                        end else begin
                            SerialChar := 'A';
                            PrefixValue := true;
                            AlternatValue := 'A = alternative item (excluded in total price)';
                        end;


                    if Type = Type::Resource then
                        if not ResourceL."Duplicate Item" then begin
                            SLNo += 1;
                            TotalSubTotal += "Line Amount";
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                        end else begin
                            SerialChar := 'A';
                            PrefixValue := true;
                            AlternatValue := 'A = alternative resource (excluded in total price)';
                        end;

                    if Type = Type::"G/L Account" then begin
                        TotalSubTotal += "Line Amount";
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                    end;
                    if Type = Type::"Fixed Asset" then begin
                        SLNo += 1;
                        TotalSubTotal += "Line Amount";
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                    end;

                    TotalInvDiscAmount -= "Inv. Discount Amount";
                    TotalAmount += Amount;


                    if (Header."Currency Code" = 'AED') OR (Header."Currency Code" = '') then begin
                        if TotalAmountVAT <> 0 then
                            TotalCaption := 'Total Amount In AED Inc.Vat'
                        else
                            TotalCaption := 'Total Amount In AED';
                    end else begin
                        //if Header."Currency Code" <> 'AED' then begin
                        if TotalAmountVAT <> 0 then
                            TotalCaption := 'Total Amount In' + ' ' + Header."Currency Code" + ' ' + 'Inc.Vat'
                        else
                            TotalCaption := 'Total Amount In' + ' ' + Header."Currency Code";
                    end;
                end;
                //end;
            }



            trigger OnAfterGetRecord()
            var
                SalesPost: Codeunit "Sales-Post";
                ContactPersonL: Record contact;
                countryRegionL: Record "Country/Region";
            begin
                Clear(CompanyAddr);
                Clear(CustAddr);

                CalcFields("No. of Archived Versions");
                SLNo := 0;
                SerialChar := '';
                Clear(WorkDescriptionG);
                WorkDescriptionG := GetWorkDescription();
                Clear(Line);
                Clear(SalesPost);
                Line.DeleteAll;
                SalesPost.GetSalesLines(Header, Line, 0);
                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".HasValue;
                //FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                //FormatAddr.SalesHeaderSellTo(CustAddr, Header);

                CompanyAddr[1] := CompanyInfo.Name;
                CompanyAddr[2] := CompanyInfo.Address;
                CompanyAddr[3] := CompanyInfo."Address 2";
                CompanyAddr[4] := CompanyInfo.City;
                CompanyAddr[5] := CompanyInfo."Post Code";
                if countryRegionL.Get(CompanyInfo."Country/Region Code") then
                    CompanyAddr[6] := countryRegionL.Name;
                CompanyAddr[7] := CompanyInfo."Phone No.";
                CompanyAddr[8] := CompanyInfo."E-Mail";
                CompanyAddr[9] := CompanyInfo."VAT Registration No.";

                CustAddr[1] := "Sell-to Customer Name";
                CustAddr[2] := "Sell-to Contact";
                if ContactPersonL.Get("Sell-to Contact No.") then begin
                    CustAddr[3] := ContactPersonL.Address;
                    CustAddr[4] := ContactPersonL."Address 2";
                    CustAddr[5] := ContactPersonL.City;
                    CustAddr[6] := ContactPersonL."Post Code";
                    if countryRegionL.Get(ContactPersonL."Country/Region Code") then
                        CustAddr[7] := countryRegionL.Name;
                    CustAddr[8] := ContactPersonL."Mobile Phone No.";
                    CustAddr[9] := ContactPersonL."E-Mail";
                    CustAddr[10] := ContactPersonL."VAT Registration No.";
                end;


                FormatDocumentFields(Header);

                if UserSetUp.Get("Assigned User ID") then;
                //if UserSetUp.FindFirst() then;
                Clear(SalespersonPurchaser);
                if SalespersonPurchaser.Get(Header."Salesperson Code") then;
                Clear(TransportMethod);
                if TransportMethod.Get(Header."Transport Method") then;

                Clear(CheckValidUpto);
                CheckValidUpto := Format(Header."Valid Up to");
                if CheckValidUpto <> '' then begin
                    CheckValidUpto := CopyStr(Format(Header."Valid Up to"), StrLen(Format(Header."Valid Up to")));
                    ValidUptoG := CopyStr(Format(Header."Valid Up to"), 1, StrLen(Format(Header."Valid Up to")) - 1);
                    case CheckValidUpto of
                        'D':
                            ValidUptoG := ValidUptoG + 'Days';
                        'W':
                            ValidUptoG := ValidUptoG + 'Weeks';
                        'Y':
                            ValidUptoG := ValidUptoG + 'Years';
                    end;
                end;

                Clear(CheckDeliveryTimes);
                CheckDeliveryTimes := Format(Header."Delivery Times");
                if CheckDeliveryTimes <> '' then begin
                    CheckDeliveryTimes := CopyStr(Format(Header."Delivery Times"), StrLen(Format(Header."Delivery Times")));
                    DeliveryTimesG := CopyStr(Format(Header."Delivery Times"), 1, StrLen(Format(Header."Delivery Times")) - 1);
                    case CheckDeliveryTimes of
                        'D':
                            DeliveryTimesG := DeliveryTimesG + 'Days';
                        'W':
                            DeliveryTimesG := DeliveryTimesG + 'Weeks';
                        'Y':
                            DeliveryTimesG := DeliveryTimesG + 'Years';
                    end;
                end;
                Clear(TotalCaption);
                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;
                Clear(SerialChar);
                Clear(PrefixValue);
                Clear(AlternatValue);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ItemNoVisible; ItemNoVisible)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item No';
                        ToolTip = 'Specifies that Item No to be visible or not';
                    }
                }
            }
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;



    var
        ItemNoVisible: Boolean;
        UserSetUp: Record "User Setup";
        SalesConfirmationLbl: Label 'Sales Quote';
        PageLbl: Label 'Page';
        PaymentTermsDescLbl: Label 'Payment Terms';
        SubtotalLbl: Label 'Subtotal';
        TotalLbl: Label 'Total';
        VATAmtLbl: Label 'VAT Amount';
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        CustAddr: array[10] of Text[100];
        CompanyAddr: array[9] of Text[100];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        FormattedVATPct: Text;
        FormattedUnitPrice: Text;
        FormattedQuantity: Text;
        FormattedLineAmount: Text;
        ShowWorkDescription: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        QuoteValidToDateLbl: Label 'Validity';
        SLNo: Integer;
        WorkDescriptionG: Text;
        SalesHeaderArchive: Record "Sales Header Archive";
        TransportMethod: Record "Transport Method";
        CheckValidUpto: Text;
        ValidUptoG: Text;
        CheckDeliveryTimes: Text;
        DeliveryTimesG: Text;
        TotalCaption: Text;
        GLDiscountAmt: Decimal;
        SerialChar: Text;
        PrefixValue: Boolean;
        AlternatValue: Text;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        FormatDocument.SetTotalLabels(SalesHeader.GetCurrencySymbol, TotalText, TotalInclVATText, TotalExclVATText);
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonText);
        FormatDocument.SetPaymentTerms(PaymentTerms, SalesHeader."Payment Terms Code", SalesHeader."Language Code");
        FormatDocument.SetPaymentMethod(PaymentMethod, SalesHeader."Payment Method Code", SalesHeader."Language Code");
        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
    end;

}
