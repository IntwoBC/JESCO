report 50110 PurchaseInvoiceRegister
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase Invoice Register';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purch. Inv. Header";
                DataItemTableView = SORTING("Document No.", "Line No.");

                trigger OnAfterGetRecord()
                var
                    DimValueL: Record "Dimension Value";
                begin
                    ShipmentG := '';//"Shipment No.";
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
                            'Third Party':
                                begin
                                    LineAmount[12] += "Line Amount";
                                    TotalLineAmt[12] += "Line Amount";
                                end;
                        end;

                    case "Purch. Inv. Line".Description of
                        'Direct expenses':
                            begin
                                LineAmount[13] += "Line Amount";
                                TotalLineAmt[13] += "Line Amount";
                            end;
                        'Certificate of Origin (IN)':
                            begin
                                LineAmount[14] += "Line Amount";
                                TotalLineAmt[14] += "Line Amount";
                            end;
                        'Certification Charges (IN))':
                            begin
                                LineAmount[15] += "Line Amount";
                                TotalLineAmt[15] += "Line Amount";
                            end;
                        'Clearance Charges (IN)':
                            begin
                                LineAmount[16] += "Line Amount";
                                TotalLineAmt[16] += "Line Amount";
                            end;
                        'Coating and Other Charges ':
                            begin
                                LineAmount[17] += "Line Amount";
                                TotalLineAmt[17] += "Line Amount";
                            end;
                        'Customs Duty (IN)':
                            begin
                                LineAmount[18] += "Line Amount";
                                TotalLineAmt[18] += "Line Amount";
                            end;
                        'Declaration of Compliance 2.1':
                            begin
                                LineAmount[19] += "Line Amount";
                                TotalLineAmt[19] += "Line Amount";
                            end;
                        'Declaration of Compliance 2.2':
                            begin
                                LineAmount[20] += "Line Amount";
                                TotalLineAmt[20] += "Line Amount";
                            end;
                        'Declaration of Conformity':
                            begin
                                LineAmount[21] += "Line Amount";
                                TotalLineAmt[21] += "Line Amount";
                            end;
                        'Delay Penalty Charges':
                            begin
                                LineAmount[22] += "Line Amount";
                                TotalLineAmt[22] += "Line Amount";
                            end;
                        'Fabricaion of Skid':
                            begin
                                LineAmount[23] += "Line Amount";
                                TotalLineAmt[23] += "Line Amount";
                            end;
                        'Freight Charges (IN)':
                            begin
                                LineAmount[24] += "Line Amount";
                                TotalLineAmt[24] += "Line Amount";
                            end;
                        'Inspection Certificate 3.1':
                            begin
                                LineAmount[25] += "Line Amount";
                                TotalLineAmt[25] += "Line Amount";
                            end;
                        'Legalization charges':
                            begin
                                LineAmount[26] += "Line Amount";
                                TotalLineAmt[26] += "Line Amount";
                            end;
                        'Packing Charges':
                            begin
                                LineAmount[27] += "Line Amount";
                                TotalLineAmt[27] += "Line Amount";
                            end;
                        'Warranty Certificate':
                            begin
                                LineAmount[28] += "Line Amount";
                                TotalLineAmt[28] += "Line Amount";
                            end;
                        'Welding Charges':
                            begin
                                LineAmount[29] += "Line Amount";
                                TotalLineAmt[29] += "Line Amount";
                            end;
                        'Works Certificate 2.2 ':
                            begin
                                LineAmount[30] += "Line Amount";
                                TotalLineAmt[30] += "Line Amount";
                            end;
                    // 'Out Put Vat 5%':
                    //     begin
                    //         LineAmount[31] += "Amount Including VAT" - "VAT Base Amount";
                    //         TotalLineAmt[31] += "Amount Including VAT" - "VAT Base Amount";
                    //     end;
                    // 'Storage & Handling charges':
                    //     begin
                    //         LineAmount[31] += "Line Amount";
                    //         TotalLineAmt[31] += "Line Amount";
                    //     end;
                    // 'Test Report for Dosing Pumps':
                    //     begin
                    //         LineAmount[32] += "Line Amount";
                    //         TotalLineAmt[32] += "Line Amount";
                    //     end;
                    // 'Advertising':
                    //     begin
                    //         LineAmount[33] += "Line Amount";
                    //         TotalLineAmt[33] += "Line Amount";
                    //     end;
                    // 'Entertainment and PR':
                    //     begin
                    //         LineAmount[34] += "Line Amount";
                    //         TotalLineAmt[34] += "Line Amount";
                    //     end;
                    // 'Travel':
                    //     begin
                    //         LineAmount[35] += "Line Amount";
                    //         TotalLineAmt[35] += "Line Amount";
                    //     end;
                    // 'Delivery Expenses':
                    //     begin
                    //         LineAmount[36] += "Line Amount";
                    //         TotalLineAmt[36] += "Line Amount";
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
                if not PurchaseRegister then
                    CurrReport.Skip();

                DateG := "Posting Date";
                NameG := "Buy-from Vendor Name";
                if CountryL.Get("Buy-from Country/Region Code") then;
                AddressG := "Buy-from Address" + ', ' + "Buy-from Address 2" + ', ' + "Buy-from City" + ', ' + "Buy-from Post Code" + ', ' + CountryL.Name;
                NoG := "No.";
                OrderNoG := "Order No.";
                VatRegNoG := "VAT Registration No.";
                ExternalNoG := "Vendor Invoice No.";
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
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            DataItemTableView = SORTING("No.");
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemLinkReference = "Purch. Cr. Memo Hdr.";
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
                            'Third Party':
                                begin
                                    LineAmount[12] += "Line Amount";
                                    TotalLineAmt[12] += "Line Amount";
                                end;
                        end;

                    case "Purch. Cr. Memo Line".Description of
                        'Direct expenses':
                            begin
                                LineAmount[13] += "Line Amount";
                                TotalLineAmt[13] += "Line Amount";
                            end;
                        'Certificate of Origin (IN)':
                            begin
                                LineAmount[14] += "Line Amount";
                                TotalLineAmt[14] += "Line Amount";
                            end;
                        'Certification Charges (IN))':
                            begin
                                LineAmount[15] += "Line Amount";
                                TotalLineAmt[15] += "Line Amount";
                            end;
                        'Clearance Charges (IN)':
                            begin
                                LineAmount[16] += "Line Amount";
                                TotalLineAmt[16] += "Line Amount";
                            end;
                        'Coating and Other Charges ':
                            begin
                                LineAmount[17] += "Line Amount";
                                TotalLineAmt[17] += "Line Amount";
                            end;
                        'Customs Duty (IN)':
                            begin
                                LineAmount[18] += "Line Amount";
                                TotalLineAmt[18] += "Line Amount";
                            end;
                        'Declaration of Compliance 2.1':
                            begin
                                LineAmount[19] += "Line Amount";
                                TotalLineAmt[19] += "Line Amount";
                            end;
                        'Declaration of Compliance 2.2':
                            begin
                                LineAmount[20] += "Line Amount";
                                TotalLineAmt[20] += "Line Amount";
                            end;
                        'Declaration of Conformity':
                            begin
                                LineAmount[21] += "Line Amount";
                                TotalLineAmt[21] += "Line Amount";
                            end;
                        'Delay Penalty Charges':
                            begin
                                LineAmount[22] += "Line Amount";
                                TotalLineAmt[22] += "Line Amount";
                            end;
                        'Fabricaion of Skid':
                            begin
                                LineAmount[23] += "Line Amount";
                                TotalLineAmt[23] += "Line Amount";
                            end;
                        'Freight Charges (IN)':
                            begin
                                LineAmount[24] += "Line Amount";
                                TotalLineAmt[24] += "Line Amount";
                            end;
                        'Inspection Certificate 3.1':
                            begin
                                LineAmount[25] += "Line Amount";
                                TotalLineAmt[25] += "Line Amount";
                            end;
                        'Legalization charges':
                            begin
                                LineAmount[26] += "Line Amount";
                                TotalLineAmt[26] += "Line Amount";
                            end;
                        'Packing Charges':
                            begin
                                LineAmount[27] += "Line Amount";
                                TotalLineAmt[27] += "Line Amount";
                            end;
                        'Warranty Certificate':
                            begin
                                LineAmount[28] += "Line Amount";
                                TotalLineAmt[28] += "Line Amount";
                            end;
                        'Welding Charges':
                            begin
                                LineAmount[29] += "Line Amount";
                                TotalLineAmt[29] += "Line Amount";
                            end;
                        'Works Certificate 2.2 ':
                            begin
                                LineAmount[30] += "Line Amount";
                                TotalLineAmt[30] += "Line Amount";
                            end;
                    // 'Out Put Vat 5%':
                    //     begin
                    //         LineAmount[31] += "Amount Including VAT" - "VAT Base Amount";
                    //         TotalLineAmt[31] += "Amount Including VAT" - "VAT Base Amount";
                    //     end;
                    // 'Storage & Handling charges':
                    //     begin
                    //         LineAmount[31] += "Line Amount";
                    //         TotalLineAmt[31] += "Line Amount";
                    //     end;
                    // 'Test Report for Dosing Pumps':
                    //     begin
                    //         LineAmount[32] += "Line Amount";
                    //         TotalLineAmt[32] += "Line Amount";
                    //     end;
                    // 'Advertising':
                    //     begin
                    //         LineAmount[33] += "Line Amount";
                    //         TotalLineAmt[33] += "Line Amount";
                    //     end;
                    // 'Entertainment and PR':
                    //     begin
                    //         LineAmount[34] += "Line Amount";
                    //         TotalLineAmt[34] += "Line Amount";
                    //     end;
                    // 'Travel':
                    //     begin
                    //         LineAmount[35] += "Line Amount";
                    //         TotalLineAmt[35] += "Line Amount";
                    //     end;
                    // 'Delivery Expenses':
                    //     begin
                    //         LineAmount[36] += "Line Amount";
                    //         TotalLineAmt[36] += "Line Amount";
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
                NameG := "Buy-from Vendor Name";
                if CountryL.Get("Buy-from Country/Region Code") then;
                AddressG := "Buy-from Address" + ', ' + "Buy-from Address 2" + ', ' + "Buy-from City" + ', ' + "Buy-from Post Code" + ', ' + CountryL.Name;
                NoG := "No.";
                OrderNoG := "Return Order No.";
                VatRegNoG := "VAT Registration No.";
                ExternalNoG := "Vendor Cr. Memo No.";
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
                    field(PurchaseRegister; PurchaseRegister)
                    {
                        ApplicationArea = All;
                        Caption = 'Purch.Inv Register';
                        ToolTip = 'Select to print sales register';
                    }
                    field(CreditRegister; CreditRegister)
                    {
                        ApplicationArea = All;
                        Caption = 'Purch.Credit Register';
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
        if PurchaseRegister AND CreditRegister then begin
            Message('You cannot run both the register,Please select either sales or credit');
            CurrReport.Quit();
        end;
        if not PurchaseRegister AND not CreditRegister then begin
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
        if PurchaseRegister then
            ExcelBuffer.CreateNewBook('Purchase Invoice Register')
        else
            ExcelBuffer.CreateNewBook('Purchase Credit Register');
        ExcelBuffer.WriteSheet('PurchInvRegister', CompanyName, UserId);
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
        PurchaseRegister: Boolean;
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
        if PurchaseRegister then
            ExcelBuffer.AddColumn('Purchase Invoice - Tax Register', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text)
        else
            ExcelBuffer.AddColumn('Purchase Credit - Tax Register', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
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
        ExcelBuffer.AddColumn('Direct expenses', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Certificate of Origin (IN)', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Certification Charges (IN)', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Clearance Charges (IN)', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Coating and Other Charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Customs Duty (IN)', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Declaration of Compliance 2.1', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Declaration of Compliance 2.2', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Declaration of Conformity', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Delay Penalty Charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Fabricaion of Skid', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Freight Charges (IN)', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Inspection Certificate 3.1', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Legalization charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Packing Charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Warranty Certificate', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Welding Charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Works Certificate 2.2', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Storage & Handling charges', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Test Report for Dosing Pumps', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn('Advertising', false, '', true, false, true, '', ExcelBuffer."Cell Type"::Text);
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

        ExcelBuffer.AddColumn(OutputVatLine, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[32], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[33], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[34], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(LineAmount[35], false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
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

        ExcelBuffer.AddColumn(TotalOutputVatLine, false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[32], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[33], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[34], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[35], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[36], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        // ExcelBuffer.AddColumn(TotalLineAmt[37], false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
    end;
}