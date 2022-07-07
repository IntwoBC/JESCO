pageextension 50103 MyExtension extends "Item Card"
{
    layout
    {
        addafter("Purchasing Code")
        {
            field("Total Price Of Assembly"; Rec."Total Price Of Assembly")
            {
                ApplicationArea = All;
            }
            field("Duplicate Item"; Rec."Duplicate Item")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Alternative Item No."; Rec."Alternative Item No.")
            {
                ApplicationArea = All;
            }
        }
        modify("Unit Price")
        {
            Editable = SetVisible;
        }
    }
    trigger OnOpenPage()
    begin
        Rec.CalcFields("Total Price Of Assembly");
        Rec."Unit Price" := Rec."Total Price Of Assembly";
        if not Rec."Assembly BOM" then
            SetVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Total Price Of Assembly");
        Rec."Unit Price" := Rec."Total Price Of Assembly";
        if not Rec."Assembly BOM" then
            SetVisible := true;
    end;

    var
        SetVisible: Boolean;
}
