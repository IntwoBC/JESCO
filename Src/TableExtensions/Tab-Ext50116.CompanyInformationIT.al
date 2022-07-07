tableextension 50116 CompanyInformationIT extends "Company Information"
{
    fields
    {
        field(50100; "Sales Order Booking Report"; Boolean)
        {
            Caption = 'Sales Order Booking Report';
            DataClassification = ToBeClassified;
        }
        field(50101; "Revenue/Invoiced Sales Report"; Boolean)
        {
            Caption = 'Revenue/Invoiced Sales Report';
            DataClassification = ToBeClassified;
        }
    }
}
