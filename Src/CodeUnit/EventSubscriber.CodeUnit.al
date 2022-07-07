codeunit 50100 "Event Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields', '', false, false)]
    local procedure OnInsertInvoiceHeaderOnAfterSalesInvHeaderTransferFields(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        SalesInvoiceHeader."Assigned User ID LT" := SalesHeader."Assigned User ID";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateEventQty(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."VAT Base Amount" <> 0 then
                Rec."Open Line Amount" := (Rec."VAT Base Amount" / Rec.Quantity) * Rec."Qty. to Invoice";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure OnAfterValidateEventUnitPrice(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."VAT Base Amount" <> 0 then
                Rec."Open Line Amount" := (Rec."VAT Base Amount" / Rec.Quantity) * Rec."Qty. to Invoice";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Line Discount %', false, false)]
    local procedure OnAfterValidateEventLineDiscountPer(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."VAT Base Amount" <> 0 then
                Rec."Open Line Amount" := (Rec."VAT Base Amount" / Rec.Quantity) * Rec."Qty. to Invoice";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Line Discount Amount', false, false)]
    local procedure OnAfterValidateEventLineDiscountAmt(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."VAT Base Amount" <> 0 then
                Rec."Open Line Amount" := (Rec."VAT Base Amount" / Rec.Quantity) * Rec."Qty. to Invoice";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Qty. to Ship', false, false)]
    local procedure OnAfterValidateEventQtytoShip(var Rec: Record "Sales Line"; CurrFieldNo: Integer; var xRec: Record "Sales Line")
    begin
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if Rec."VAT Base Amount" <> 0 then
                Rec."Open Line Amount" := (Rec."VAT Base Amount" / Rec.Quantity) * Rec."Qty. to Invoice";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Sales-Post (Yes/No)", 'OnAfterPost', '', false, false)]
    local procedure OnAfterActionEventPost(var SalesHeader: Record "Sales Header")
    var
        SalesLineL: Record "Sales Line";
    begin
        SalesLineL.SetRange("Document Type", SalesLineL."Document Type"::Order);
        SalesLineL.SetRange("Document No.", SalesHeader."No.");
        SalesLineL.SetFilter("Qty. to Invoice", '<>%1', 0);
        SalesLineL.SetFilter("VAT Base Amount", '<>%1', 0);
        if SalesLineL.FindSet() then begin
            repeat
                SalesLineL."Open Line Amount" := (SalesLineL."VAT Base Amount" / SalesLineL.Quantity) * SalesLineL."Qty. to Invoice";
                SalesLineL.Modify(true);
            until SalesLineL.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterCalculateSalesSubPageTotals', '', false, false)]
    local procedure OnAfterCalculateSalesSubPageTotals(var InvoiceDiscountAmount: Decimal; var InvoiceDiscountPct: Decimal;
    var TotalSalesHeader: Record "Sales Header"; var TotalSalesLine2: Record "Sales Line"; var TotalSalesLine: Record "Sales Line";
    var VATAmount: Decimal)
    begin
        TotalSalesLine2.SetRange("Document Type", TotalSalesLine2."Document Type"::Order);
        TotalSalesLine2.SetRange("Document No.", TotalSalesHeader."No.");
        TotalSalesLine2.SetFilter("Qty. to Invoice", '<>%1', 0);
        TotalSalesLine2.CalcSums(TotalSalesLine2."Open Line Amount");
    end;
}