tableextension 50114 "Resource_Ext" extends Resource
{
    fields
    {
        field(50000; "Duplicate Item"; Boolean)
        {
            Caption = 'Duplicate Item';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}