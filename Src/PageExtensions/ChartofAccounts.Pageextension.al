pageextension 50122 "Chart of Accounts" extends "Chart of Accounts"
{

    trigger OnOpenPage()
    var
        usersetupL: Record "User Setup";
    begin
        Clear(usersetupL);
        usersetupL.SetRange("User ID", UserId);
        if usersetupL.FindFirst() then begin
            if not usersetupL."Allow Chart Of Account_Jesco" then
                Error('You do not have permissions for accessing Chart of Account');
        end;
    end;
}