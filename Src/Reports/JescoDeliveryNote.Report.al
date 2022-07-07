report 50103 "Jesco Delivery Note"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\Layout Reports Rdls\JescoDeliveryNote.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.";
            RequestFilterHeading = 'Posted Sales Shipment';

            //**********************Customer Details*************************
            column(ShippingVisible; ShippingVisible) { }
            column(Page_Lbl; PageLbl) { }
            column(DocumentTitle_Lbl; DelLbl) { }
            column(ShowTitle; ShowTitle) { }
            column(Cust_Name; Cust.Name) { }
            column(Cust_add1; Cust.Address) { }
            column(Cust_add2; Cust."Address 2") { }
            column(Cust_Post_Code; Cust."Post Code") { }
            column(Cust_Country; CountryRegion.Name) { } //Cust."Country/Region Code") { }
            column(Cust_VatRegNo; Cust."VAT Registration No.") { }
            column(Ship_to_Name; "Ship-to Name") { }
            column(Ship_to_Address; "Ship-to Address") { }
            column(Ship_to_Address_2; "Ship-to Address 2") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Ship_to_Post_Code; "Ship-to Post Code") { }
            column(Ship_to_County; "Ship-to County") { }
            column(Ship_to_Country_Region_Code; "Ship-to Country/Region Code") { }
            //**********************Customer Details*************************
            //**********************Header Details*************************
            column(VAT_Registration_No_; "VAT Registration No.") { }
            column(No_; "No.") { }
            column(Posting_Date; Format("Posting Date", 0, 4)) { }
            column(Document_Date; Format("Document Date", 0, 4)) { }
            column(External_Document_No_; "External Document No.") { }
            column(Order_No_; "Order No.") { }
            column(Order_Date; "Order Date") { }
            column(WorkDesc; GetWorkDescription()) { }
            column(Sell_to_Customer_No_; "Sell-to Customer No.") { }
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
            column(CompInfo_ContactName; CompanyInfo."Contact Person") { }
            //**********************Footer Details*************************
            column(User_ID; "User ID") { }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Shipment Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                column(SrNo; SrNo) { }
                column(No_Item; "No.") { }
                column(Type_LineNumber; Format(Type.AsInteger())) { }
                column(Quantity; Quantity) { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(Description; Description) { }
                trigger OnAfterGetRecord()
                begin
                    if Type = Type::Item then begin
                        if Quantity <> 0 then
                            SrNo += 1;
                    end;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter(Type, '<>%1', Type::"G/L Account");
                end;

            }
            trigger OnAfterGetRecord()
            begin
                SrNo := 0;
                if Cust.Get("Sell-to Customer No.") then;
                Clear(CountryRegion);
                if CountryRegion.Get(Cust."Country/Region Code") then;
            end;

            trigger OnPreDataItem()
            begin
                if PackingList then
                    ShowTitle := 'Packing List'
                else
                    ShowTitle := 'Delivery Note';

                // if ShippingVisible then
                //     ShippingAddr := true
                // else
                //     ShippingAddr := false;
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
                    field(PackingList; PackingList)
                    {
                        ApplicationArea = All;
                        Caption = 'Packing List';
                    }
                    field(ShippingVisible; ShippingVisible)
                    {
                        ApplicationArea = All;
                        Caption = 'Shipping Address';
                    }
                }
            }
        }
    }
    labels
    {
        CustLbl = 'Customer :';
        PoBoxLbl = 'Po Box -';
        TRNLbl = 'TRN :';
        SlnoLbl = 'SL No';
        TRLbl = 'TRN';
        TaxInvnoLbl = 'Tax Invoice No';
        DateofInvLbl = 'Date of Invoice';
        DateofSuppLbl = 'Date of Supply';
        JobLbl = 'Job No';
        LpoRefLbl = 'LPO Ref No';
        LpoDateLbl = 'LPO Date';
        DNLbl = 'DN No';
        MRFLbl = 'MRF No';
        PreparedLbl = 'Prepared By';
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
        SrNo: Integer;
        PageLbl: Label 'Page';
        DelLbl: Label 'Delivery Note';
        PackingList: Boolean;
        ShowTitle: Text;
        CountryRegion: Record "Country/Region";
        ShippingVisible: Boolean;
}
