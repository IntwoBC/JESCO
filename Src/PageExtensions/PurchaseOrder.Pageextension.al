pageextension 50113 "Purchaseorder_Ext" extends "Purchase Order"
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Document Required"; Rec."Document Required")
            {
                ApplicationArea = All;
            }
        }
        addafter("Document Required")
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
        addafter(Status)
        {
            group("Work Description")
            {
                Caption = 'Work Description';
                field(WorkDescription; WorkDescription)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    MultiLine = true;
                    ShowCaption = false;
                    ToolTip = 'Specifies the products or service being offered';

                    trigger OnValidate()
                    begin
                        Rec.SetWorkDescription(WorkDescription);
                    end;
                }
            }
        }
        modify("Vendor Order No.")
        {
            Caption = 'Sales Order No.';
        }
    }
    actions
    {
        modify(Release)
        {
            trigger OnAfterAction();
            begin
                PrintVisible := true;
            end;
        }
        modify(Reopen)
        {
            trigger OnAfterAction();
            begin
                PrintVisible := false;
            end;
        }
        modify("&Print")
        {
            Visible = PrintVisible;
        }
    }
    trigger OnAfterGetRecord()
    begin
        WorkDescription := Rec.GetWorkDescription;
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Released then
            PrintVisible := true;
    end;

    var
        WorkDescription: Text;
        PrintVisible: Boolean;
}