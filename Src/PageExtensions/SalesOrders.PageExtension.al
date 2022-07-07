pageextension 50100 SalesOrders_Ext extends "Sales Orders"
{
    actions
    {
        addlast(Processing)
        {
            action(ProformaInvoice)
            {
                ApplicationArea = All;
                Caption = 'Jesco Proforma Invoice';
                Image = Print;

                trigger OnAction()
                var
                    SalesHeaderL: Record "Sales Header";
                begin
                    SalesHeaderL.SetRange("No.", Rec."No.");
                    SalesHeaderL.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    if SalesHeaderL.FindFirst() then Report.Run(Report::"Jesco Sales-Proforma Invoice", true, true, SalesHeaderL);
                end;
            }
        }
    }
}
