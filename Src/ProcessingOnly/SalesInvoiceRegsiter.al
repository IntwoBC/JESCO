report 50109 SalesInvoiceRegister
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sales Invoice Register';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Invoice Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                var
                    DimValueL: Record "Dimension Value";
                begin
                    ShipmentG := "Shipment No.";
                    Qtysub += Quantity;
                    TotalQty += Quantity;
                    OutputVatLine += "Amount Including VAT" - Amount;
                    TotalOutputVatLine += "Amount Including VAT" - Amount;
                    if DimValueL.Get(GLSetup."Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code") then
                        case DimValueL.Name of
                            'Dosing pumps & accessories':
                                begin
                                    LineAmount[1] += "Line Amount";
                                    TotalLineAmt[1] += "Line Amount";
                                end;
                            'Centrifugal':
                                begin
                                    LineAmount[2] += "Line Amount";
                                    TotalLineAmt[2] += "Line Amount";
                                end;
                            'Chlorination systems & accessories':
                                begin
                                    LineAmount[3] += "Line Amount";
                                    TotalLineAmt[3] += "Line Amount";
                                end;
                            'Disinfection systems':
                                begin
                                    LineAmount[4] += "Line Amount";
                                    TotalLineAmt[4] += "Line Amount";
                                end;
                            'Drum Pumps':
                                begin
                                    LineAmount[5] += "Line Amount";
                                    TotalLineAmt[5] += "Line Amount";
                                end;
                            'Instrumentation':
                                begin
                                    LineAmount[6] += "Line Amount";
                                    TotalLineAmt[6] += "Line Amount";
                                end;
                            'Measurement & control':
                                begin
                                    LineAmount[7] += "Line Amount";
                                    TotalLineAmt[7] += "Line Amount";
                                end;
                            'Skid systems':
                                begin
                                    LineAmount[8] += "Line Amount";
                                    TotalLineAmt[8] += "Line Amount";
                                end;
                            'Chlorination systems spare parts':
                                begin
                                    LineAmount[9] += "Line Amount";
                                    TotalLineAmt[9] += "Line Amount";
                                end;
                            'Dosing pumps spare parts':
                                begin
                                    LineAmount[10] += "Line Amount";
                                    TotalLineAmt[10] += "Line Amount";
                                end;
                            'Technopool':
                                begin
                                    LineAmount[11] += "Line Amount";
                                    TotalLineAmt[11] += "Line Amount";
                                end;
                            'Agent commission':
                                begin
                                    LineAmount[12] += "Line Amount";
                                    TotalLineAmt[12] += "Line Amount";
                                end;
                            'Third Party':
                                begin
                                    LineAmount[13] += "Line Amount";
                                    TotalLineAmt[13] += "Line Amount";
                                end;
                        end;

                    case "Sales Invoice Line".Description of
                        'Sales of Resources':
                            begin
                                LineAmount[14] += "Line Amount";
                                TotalLineAmt[14] += "Line Amount";
                            end;
                        'Calibration charges collected':
                            begin
                                LineAmount[15] += "Line Amount";
                                TotalLineAmt[15] += "Line Amount";
                            end;
                        'Certification Charges Collected':
                            begin
                                LineAmount[16] += "Line Amount";
                                TotalLineAmt[16] += "Line Amount";
                            end;
                        'Clearance charges collected':
                            begin
                                LineAmount[17] += "Line Amount";
                                TotalLineAmt[17] += "Line Amount";
                            end;
                        'Courier charges collected':
                            begin
                                LineAmount[18] += "Line Amount";
                                TotalLineAmt[18] += "Line Amount";
                            end;
                        'Sales, Resources - Dom.':
                            begin
                                LineAmount[19] += "Line Amount";
                                TotalLineAmt[19] += "Line Amount";
                            end;
                        'Freight charges collected':
                            begin
                                LineAmount[20] += "Line Amount";
                                TotalLineAmt[20] += "Line Amount";
                            end;
                        'Other Income':
                            begin
                                LineAmount[21] += "Line Amount";
                                TotalLineAmt[21] += "Line Amount";
                            end;
                        'Profit/loss on sale of Fixed Asset':
                            begin
                                LineAmount[22] += "Line Amount";
                                TotalLineAmt[22] += "Line Amount";
                            end;
                        'Remission of liability':
                            begin
                                LineAmount[23] += "Line Amount";
                                TotalLineAmt[23] += "Line Amount";
                            end;
                        'Reversal of provisions':
                            begin
                                LineAmount[24] += "Line Amount";
                                TotalLineAmt[24] += "Line Amount";
                            end;
                        'Site visit/ commissioning charges collected':
                            begin
                                LineAmount[25] += "Line Amount";
                                TotalLineAmt[25] += "Line Amount";
                            end;
                        'Storage charges collected':
                            begin
                                LineAmount[26] += "Line Amount";
                                TotalLineAmt[26] += "Line Amount";
                            end;
                        'Test reports charegs collected':
                            begin
                                LineAmount[27] += "Line Amount";
                                TotalLineAmt[27] += "Line Amount";
                            end;
                        'Transportation charges collected':
                            begin
                                LineAmount[28] += "Line Amount";
                                TotalLineAmt[28] += "Line Amount";
                            end;
                        'Sales, Resources - EU':
                            begin
                                LineAmount[29] += "Line Amount";
                                TotalLineAmt[29] += "Line Amount";
                            end;
                        'Customs Duty Collected':
                            begin
                                LineAmount[30] += "Line Amount";
                                TotalLineAmt[30] += "Line Amount";
                            end;
                        'Sales, Resources - Export':
                            begin
                                LineAmount[31] += "Line Amount";
                                TotalLineAmt[31] += "Line Amount";
                            end;
                        'Job Sales Applied, Resources':
                            begin
                                LineAmount[32] += "Line Amount";
                                TotalLineAmt[32] += "Line Amount";
                            end;
                        'Job Sales Adjmt., Resources':
                            begin
                                LineAmount[33] += "Line Amount";
                                TotalLineAmt[33] += "Line Amount";
                            end;
                        'Total Sales of Resources':
                            begin
                                LineAmount[34] += "Line Amount";
                                TotalLineAmt[34] += "Line Amount";
                            end;
                    // 'Out Put Vat 5%':
                    //     begin
                    //         LineAmount[35] += "Amount Including VAT" - "VAT Base Amount";
                    //         TotalLineAmt[35] += "Amount Including VAT" - "VAT Base Amount";
                    //     end;
                    // 'Test Report for Dosing Pumps':
                    //     begin
                    //         LineAmount[35] += "Line Amount";
                    //         TotalLineAmt[35] += "Line Amount";
                    //     end;
                    // 'Advertising':
                    //     begin
                    //         LineAmount[36] += "Line Amount";
                    //         TotalLineAmt[36] += "Line Amount";
                    //     end;
                    // 'Entertainment and PR':
                    //     begin
                    //         LineAmount[37] += "Line Amount";
                    //         TotalLineAmt[37] += "Line Amount";
                    //     end;
                    // 'Travel':
                    //     begin
                    //         LineAmount[38] += "Line Amount";
                    //         TotalLineAmt[38] += "Line Amount";
                    //     end;
                    // 'Delivery Expenses':
                    //     begin
                    //         LineAmount[39] += "Line Amount";
                    //         TotalLineAmt[39] += "Line Amount";
                    //     end;
                    end;

                    SubTotal += "Line Amount";
                    TotalAmtExclVat += "Line Amount";
                end;

                trigger OnPreDataItem()
                begin
                    Clear(Qtysub);
                    Clear(LineAmount);
                    Clear(SubTotal);
                    Clear(ShipmentG);
                end;

                trigger OnPostDataItem()
                begin
                    MakeBodyDetails();
                end;
            }
            trigger OnAfterGetRecord()
            var
                CountryL: Record "Country/Region";
                DimensionSetEnstryL: Record "Dimension Set Entry";
            begin
                Clear(DateG);
                Clear(NameG);
                Clear(AddressG);
                Clear(NoG);
                Clear(OrderNoG);
                Clear(VatRegNoG);
                Clear(ExternalNoG);
                Clear(TransportG);
                Clear(DimCountryNameG);
                Clear(DocDateG);
                Clear(OutputVatLine);
                if not SalesRegister then
                    CurrReport.Skip();

                DateG := "Posting Date";
                NameG := "Sell-to Customer Name";
                if CountryL.Get("Sell-to Country/Region Code") then;
                AddressG := "Sell-to Address" + ', ' + "Sell-to Address 2" + ', ' + "Sell-to City" + ', ' + "Sell-to Post Code" + ', ' + CountryL.Name;
                NoG := "No.";
                OrderNoG := "Order No.";
                VatRegNoG := "VAT Registration No.";
                ExternalNoG := "External Document No.";
                TransportG := "Transport Method";
                if DimensionSetEnstryL.Get("Dimension Set ID", 'ITEM CATEGORY') then
                    DimCountryNameG := DimensionSetEnstryL."Dimension Value Code";

                DocDateG := "Document Date";
            end;

            trigger OnPreDataItem()
            begin
                if (StartDateG <> 0D) and (EndDateG <> 0D) then
                    SetFilter("Posting Date", '%1..%2', StartDateG, EndDateG);
            end;
        }

        //************************************************Sales Credit Memo********************************************************
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Sales Cr.Memo Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                var
                    DimValueL: Record "Dimension Value";
                begin
                    ShipmentG := '';
                    Qtysub += Quantity;
                    TotalQty += Quantity;
                    OutputVatLine += "Amount Including VAT" - Amount;
                    TotalOutputVatLine += "Amount Including VAT" - Amount;
                    if DimValueL.Get(GLSetup."Shortcut Dimension 2 Code", "Shortcut Dimension 2 Code") then
                        case DimValueL.Name of
                            'Dosing pumps & accessories':
                                begin
                                    LineAmount[1] += "Line Amount";
                                    TotalLineAmt[1] += "Line Amount";
                                end;
                            'Centrifugal':
                                begin
                                    LineAmount[2] += "Line Amount";
                                    TotalLineAmt[2] += "Line Amount";
                                end;
                            'Chlorination systems & accessories':
                                begin
                                    LineAmount[3] += "Line Amount";
                                    TotalLineAmt[3] += "Line Amount";
                                end;
                            'Disinfection systems':
                                begin
                                    LineAmount[4] += "Line Amount";
                                    TotalLineAmt[4] += "Line Amount";
                                end;
                            'Drum Pumps':
                                begin
                                    LineAmount[5] += "Line Amount";
                                    TotalLineAmt[5] += "Line Amount";
                                end;
                            'Instrumentation':
                                begin
                                    LineAmount[6] += "Line Amount";
                                    TotalLineAmt[6] += "Line Amount";
                                end;
                            'Measurement & control':
                                begin
                                    LineAmount[7] += "Line Amount";
                                    TotalLineAmt[7] += "Line Amount";
                                end;
                            'Skid systems':
                                begin
                                    LineAmount[8] += "Line Amount";
                                    TotalLineAmt[8] += "Line Amount";
                                end;
                            'Chlorination systems spare parts':
                                begin
                                    LineAmount[9] += "Line Amount";
                                    TotalLineAmt[9] += "Line Amount";
                                end;
                            'Dosing pumps spare parts':
                                begin
                                    LineAmount[10] += "Line Amount";
                                    TotalLineAmt[10] += "Line Amount";
                                end;
                            'Technopool':
                                begin
                                    LineAmount[11] += "Line Amount";
                                    TotalLineAmt[11] += "Line Amount";
                                end;
                            'Agent commission':
                                begin
                                    LineAmount[12] += "Line Amount";
                                    TotalLineAmt[12] += "Line Amount";
                                end;
                            'Third Party':
                                begin
                                    LineAmount[13] += "Line Amount";
                                    TotalLineAmt[13] += "Line Amount";
                                end;
                        end;

                    case "Sales Cr.Memo Line".Description of
                        'Sales of Resources':
                            begin
                                LineAmount[14] += "Line Amount";
                                TotalLineAmt[14] += "Line Amount";
                            end;
                        'Calibration charges collected':
                            begin
                                LineAmount[15] += "Line Amount";
                                TotalLineAmt[15] += "Line Amount";
                            end;
                        'Certification Charges Collected':
                            begin
                                LineAmount[16] += "Line Amount";
                                TotalLineAmt[16] += "Line Amount";
                            end;
                        'Clearance charges collected':
                            begin
                                LineAmount[17] += "Line Amount";
                                TotalLineAmt[17] += "Line Amount";
                            end;
                        'Courier charges collected':
                            begin
                                LineAmount[18] += "Line Amount";
                                TotalLineAmt[18] += "Line Amount";
                            end;
                        'Sales, Resources - Dom.':
                            begin
                                LineAmount[19] += "Line Amount";
                                TotalLineAmt[19] += "Line Amount";
                            end;
                        'Freight charges collected':
                            begin
                                LineAmount[20] += "Line Amount";
                                TotalLineAmt[20] += "Line Amount";
                            end;
                        'Other Income':
                            begin
                                LineAmount[21] += "Line Amount";
                                TotalLineAmt[21] += "Line Amount";
                            end;
                        'Profit/loss on sale of Fixed Asset':
                            begin
                                LineAmount[22] += "Line Amount";
                                TotalLineAmt[22] += "Line Amount";
                            end;
                        'Remission of liability':
                            begin
                                LineAmount[23] += "Line Amount";
                                TotalLineAmt[23] += "Line Amount";
                            end;
                        'Reversal of provisions':
                            begin
                                LineAmount[24] += "Line Amount";
                                TotalLineAmt[24] += "Line Amount";
                            end;
                        'Site visit/ commissioning charges collected':
                            begin
                                LineAmount[25] += "Line Amount";
                                TotalLineAmt[25] += "Line Amount";
                            end;
                        'Storage charges collected':
                            begin
                                LineAmount[26] += "Line Amount";
                                TotalLineAmt[26] += "Line Amount";
                            end;
                        'Test reports charegs collected':
                            begin
                                LineAmount[27] += "Line Amount";
                                TotalLineAmt[27] += "Line Amount";
                            end;
                        'Transportation charges collected':
                            begin
                                LineAmount[28] += "Line Amount";
                                TotalLineAmt[28] += "Line Amount";
                            end;
                        'Sales, Resources - EU':
                            begin
                                LineAmount[29] += "Line Amount";
                                TotalLineAmt[29] += "Line Amount";
                            end;
                        'Customs Duty Collected':
                            begin
                                LineAmount[30] += "Line Amount";
                                TotalLineAmt[30] += "Line Amount";
                            end;
                        'Sales, Resources - Export':
                            begin
                                LineAmount[31] += "Line Amount";
                                TotalLineAmt[31] += "Line Amount";
                            end;
                        'Job Sales Applied, Resources':
                            begin
                                LineAmount[32] += "Line Amount";
                                TotalLineAmt[32] += "Line Amount";
                            end;
                        'Job Sales Adjmt., Resources':
                            begin
                                LineAmount[33] += "Line Amount";
                                TotalLineAmt[33] += "Line Amount";
                            end;
                        'Total Sales of Resources':
                            begin
                                LineAmount[34] += "Line Amount";
                                TotalLineAmt[34] += "Line Amount";
                            end;
                    // 'Out Put Vat 5%':
                    //     begin
                    //         LineAmount[35] += "Amount Including VAT" - "VAT Base Amount";
                    //         TotalLineAmt[35] += "Amount Including VAT" - "VAT Base Amount";
                    //     end;

                    // 'Test Report for Dosing Pumps':
                    //     begin
                    //         LineAmount[35] += "Line Amount";
                    //         TotalLineAmt[35] += "Line Amount";
                    //     end;
                    // 'Advertising':
                    //     begin
                    //         LineAmount[36] += "Line Amount";
                    //         TotalLineAmt[36] += "Line Amount";
                    //     end;
                    // 'Entertainment and PR':
                    //     begin
                    //         LineAmount[37] += "Line Amount";
                    //         TotalLineAmt[37] += "Line Amount";
                    //     end;
                    // 'Travel':
                    //     begin
                    //         LineAmount[38] += "Line Amount";
                    //         TotalLineAmt[38] += "Line Amount";
                    //     end;
                    // 'Delivery Expenses':
                    //     begin
                    //         LineAmount[39] += "Line Amount";
                    //         TotalLineAmt[39] += "Line Amount";
                    //     end;
                    end;

                    SubTotal += "Line Amount";
                    TotalAmtExclVat += "Line Amount";
                end;

                trigger OnPreDataItem()
                begin
                    Clear(Qtysub);
                    Clear(LineAmount);
                    Clear(SubTotal);
                    Clear(ShipmentG);
                end;

                trigger OnPostDataItem()
                begin
                    MakeBodyDetails();
                end;
            }
            trigger OnAfterGetRecord()
            var
                CountryL: Record "Country/Region";
                DimensionSetEnstryL: Record "Dimension Set Entry";
            begin
                Clear(DateG);
                Clear(NameG);
                Clear(AddressG);
                Clear(NoG);
                Clear(OrderNoG);
                Clear(VatRegNoG);
                Clear(ExternalNoG);
                Clear(TransportG);
                Clear(DimCountryNameG);
                Clear(DocDateG);
                Clear(OutputVatLine);
                if not CreditRegister then
                    CurrReport.Skip();

                DateG := "Posting Date";
                NameG := "Sell-to Customer Name";
                if CountryL.Get("Sell-to Country/Region Code") then;
                AddressG := "Sell-to Address" + ', ' + "Sell-to Address 2" + ', ' + "Sell-to City" + ', ' + "Sell-to Post Code" + ', ' + CountryL.Name;
                NoG := "No.";
                OrderNoG := "Return Order No.";
                VatRegNoG := "VAT Registration No.";
                ExternalNoG := "External Document No.";
                TransportG := "Transport Method";
                ShipmentG := "Shipment Method Code";
                if DimensionSetEnstryL.Get("Dimension Set ID", 'ITEM CATEGORY') then
                    DimCountryNameG := DimensionSetEnstryL."Dimension Value Code";

                DocDateG := "Document Date";
            end;

            trigger OnPreDataItem()
            begin
                if (StartDateG <> 0D) and (EndDateG <> 0D) then
                    SetFilter("Posting Date", '%1..%2', StartDateG, EndDateG);
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
                    field(SalesRegister; SalesRegister)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales.Inv Register';
                        ToolTip = 'Select to print sales register';
                    }
                    field(CreditRegister; CreditRegister)
                    {
                        ApplicationArea = All;
                        Caption = 'Sales.Credit Register';
                        ToolTip = 'Select to print Credit register';
                    }
                    field(StartDateG; StartDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(EndDateG; EndDateG)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        ExcelBuffer.DeleteAll();
        if SalesRegister AND CreditRegister then begin
            Message('You cannot run both the register,Please select either sales or credit');
            CurrReport.Quit();
        end;
        if not SalesRegister AND not CreditRegister then begin
            Message('Please select any one of the register');
            CurrReport.Quit();
        end;
        GLSetup.Get();
        CompanyInfo.Get();
        MakeCompanyInformation();
        MakeHeaderDetails();
    end;

    trigger OnPostReport()
    begin
        MakeLineTotal();
        if SalesRegister then
            ExcelBuffer.CreateNewBook('Sales Invoice Register')
        else
            ExcelBuffer.CreateNewBook('Sales Credit Register');
        ExcelBuffer.WriteSheet('', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.OpenExcel();
    end;

    var
        ExcelBuffer: Record "Excel Buffer";
        Qtysub: Integer;
        LineAmount: array[37] of Decimal;
        TotalLineAmt: array[37] of Decimal;
        StartDateG: Date;
        EndDateG: Date;
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        TotalQty: Integer;
        SubTotal: Decimal;
        TotalAmtExclVat: Decimal;
        SalesRegister: Boolean;
        CreditRegister: Boolean;
        DateG: Date;
        NameG: Text;
        AddressG: Text;
        NoG: Code[20];
        OrderNoG: code[20];
        VatRegNoG: Code[50];
        ExternalNoG: Code[50];
        TransportG: Code[50];
        ShipmentG: Code[50];
        DimCountryNameG: Text;
        DocDateG: Date;
        OutputVatLine: Decimal;
        TotalOutputVatLine: Decimal;

    local procedure MakeCompanyInformation()
    var
        startDL: Text;
        EndDL: Text;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(CompanyInfo.Name, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(CompanyInfo.Address, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(CompanyInfo."Address 2" + ',' + ' ' + CompanyInfo.City, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(CompanyInfo."Contact Person", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(CompanyInfo.City, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.NewRow();
        if SalesRegister then
            ExcelBuffer.AddColumn('Sales Invoice- Tax Register', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
        else
            ExcelBuffer.AddColumn('Sales Credit - Tax Register', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        startDL := Format(StartDateG);
        EndDL := Format(EndDateG);
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(startDL + ' ' + 'to' + ' ' + EndDL, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeHeaderDetails()
    var
        myInt: Integer;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Particulars', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Address', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Voucher No.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Order No / Job No', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('TRN', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order No. & Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Delivery Terms', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Delivery Note No. & Date', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Country', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross Total', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dosing pumps & accessories', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Centrifugal', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Chlorination systems & accessories', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Disinfection systems', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Drum Pumps', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Instrumentation', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Measurement & control', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Skid systems', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Chlorination systems spare parts', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dosing pumps spare parts', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Technopool', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Agent commission', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Third party', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales of Resources', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Calibration charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Certification Charges Collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Clearance charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Courier charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales, Resources - Dom.', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Freight charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Other Income', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Profit/loss on sale of Fixed Asset', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remission of liability', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Reversal of provisions', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Site visit/ commissioning charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Storage charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Test reports charegs collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Transportation charges collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales, Resources - EU', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customs Duty Collected', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales, Resources - Export', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Job Sales Applied, Resources', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Job Sales Adjmt., Resources', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Total Sales of Resources', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Entertainment and PR', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Travel', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Delivery Expenses', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Out Put Vat 5%', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
    end;


    local procedure MakeBodyDetails()
    var
        myInt: Integer;
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn(DateG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(NameG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(AddressG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(NoG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(OrderNoG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(VatRegNoG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ExternalNoG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TransportG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(ShipmentG + '' + Format(DocDateG), false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(DimCountryNameG, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(Qtysub, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(SubTotal, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(LineAmount[1], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[2], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[3], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[4], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[5], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[6], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[7], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[8], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[9], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[10], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(LineAmount[11], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[12], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[13], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[14], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[15], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[16], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[17], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[18], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[19], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[20], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(LineAmount[21], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[22], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[23], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[24], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[25], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[26], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[27], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[28], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[29], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[30], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(LineAmount[31], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[32], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[33], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(LineAmount[34], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(OutputVatLine, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[36], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[37], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;

    local procedure MakeLineTotal()
    begin
        ExcelBuffer.NewRow();
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Grand Total', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(TotalQty, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalAmtExclVat, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(TotalLineAmt[1], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[2], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[3], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[4], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[5], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[6], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[7], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[8], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[9], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[10], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(TotalLineAmt[11], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[12], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[13], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[14], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[15], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[16], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[17], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[18], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[19], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[20], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(TotalLineAmt[21], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[22], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[23], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[24], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[25], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[26], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[27], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[28], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[29], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[30], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

        ExcelBuffer.AddColumn(TotalLineAmt[31], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[32], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[33], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalLineAmt[34], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn(TotalOutputVatLine, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[36], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[37], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;
}