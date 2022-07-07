tableextension 50103 Purchase_Line extends "Purchase Line"
{
    fields
    {
        field(50000; "Bill of Entry No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}