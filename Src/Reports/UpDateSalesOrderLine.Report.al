report 50114 "Sales Order Lines Update"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Sales Line"; "Sales Line")
        {
            DataItemTableView = sorting("Document Type", "Document No.") where("Document Type" = const(Order), "VAT Base Amount" = filter(<> 0));
            RequestFilterFields = "Document No.";
            trigger OnAfterGetRecord()
            var
                SalesLineL: Record "Sales Line";
            begin
                "Open Line Amount" := ("VAT Base Amount" / Quantity) * "Qty. to Invoice";
                Modify(true);
            end;
        }
    }
}