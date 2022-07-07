tableextension 50106 PurchaseHeader_Ext extends "Purchase Header"
{
    fields
    {
        field(50000; "Document Required"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Required';
        }
        field(50001; "Work Description"; Blob)
        {
            Caption = 'Work Description';
        }
    }

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';

    procedure SetWorkDescription(NewWorkDescription: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Work Description");
        "Work Description".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(NewWorkDescription);
        Modify;
    end;

    procedure GetWorkDescription() WorkDescription: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Work Description");
        "Work Description".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), WorkDescription) then
            Message(ReadingDataSkippedMsg, FieldCaption("Work Description"));
    end;
}
