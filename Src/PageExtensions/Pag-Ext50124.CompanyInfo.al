pageextension 50124 CompanyInfo extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("Sales Order Booking Report"; Rec."Sales Order Booking Report")
            {
                ApplicationArea = All;
            }
            field("Revenue/Invoiced Sales Report"; Rec."Revenue/Invoiced Sales Report")
            {
                ApplicationArea = All;
            }
        }
    }
}
