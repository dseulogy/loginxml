ACCOUNTLOGIN_FADEIN_TIME1 = 1.0;
ACCOUNTLOGIN_FADEIN_TIME2 = 1.5;
ACCOUNTLOGIN_AGREEMENT = false;


function AccountLogin_OnShow()
	if ( GetLocation() == "JP" ) then
		UserAgreement:Hide();
		if ( ACCOUNTLOGIN_AGREEMENT ) then
			ACCOUNTLOGIN_AGREEMENT = nil;
			AccountLoginShow();
		end
	end

	if ( ACCOUNTLOGIN_AGREEMENT ) then
		ACCOUNTLOGIN_AGREEMENT = nil;
		AccountLogin:Hide();
		UserAgreement:Show();
	else
		AccountLoginPasswordEdit:SetFocus();
	end
end

function AccountLogin_OnKeyDown(this, key)
	if ( key == "ESCAPE" ) then
		AccountLogin_Exit();
	end
end

function AccountLogin_OnKeyUp(this, key)

end

function AccountLogin_OnMouseDown(this, key)

end

function AccountLogin_OnMouseUp(this, key)

end

function AccountLogin_OnUpdate(this, elapsedTime)
	if ( AccountLogin.update ) then
		AccountLogin.update = AccountLogin.update + elapsedTime;
		Alpha = ( AccountLogin.update - ACCOUNTLOGIN_FADEIN_TIME1 ) / ACCOUNTLOGIN_FADEIN_TIME2;
		if( Alpha < 0 )then
			Alpha = 0;
		elseif( Alpha > 1.0 )then
			Alpha = 1.0;
		end
		AccountLogin:SetAlpha( Alpha );

		if ( Alpha >= 1.0 ) then
			AccountLogin.update = nil;
		end
	end
end

function AccountLogin_Login()
	DefaultServerLogin(AccountLoginAccountEdit:GetText(), AccountLoginPasswordEdit:GetText());
	AccountLoginPasswordEdit:SetText("");
	AccountLoginAccountEdit:ClearFocus();
	AccountLoginPasswordEdit:ClearFocus();
end

function AccountLogin_FocusPassword()
	AccountLoginPasswordEdit:SetFocus();
end

function AccountLogin_FocusAccountName()
	AccountLoginAccountEdit:SetFocus();
end

function AccountLoginPasswordEdit_OnGained(this, arg1)
	
end

function AccountLoginPasswordEdit_SetText(text)
	AccountLoginPasswordEdit:InsertChar(text);
end

function AccountLogin_Exit()
	QuitGame();
end

function AccountLogin_OnLoad()
	local imageLocation = GetImageLocation("LOGO");
	local file = "Interface\\Login\\Logo\\"..imageLocation.."\\RA_LOGO";
	AccountLogin.update = nil;
	AccountLoginVersion:SetText(GetVersion());
	AccountLoginLogo:SetTexture(file);
end

function AccountLogin_Show()
	AccountLogin.update = 0;
	AccountLogin:SetAlpha(0);
	AccountLogin:Show();
end

function AccountLoginBoard_OnLoad(this)
	this:RegisterEvent("SERVER_BOARD_UPDATE");
end

function AccountLoginBoard_OnEvent(this, event)
	if ( event == "SERVER_BOARD_UPDATE" ) then
		AccountLoginBoardText:SetText(GetServerBoardText());
		AccountLoginBoardScrollFrame:UpdateScrollChildRect();
		AccountLoginBoard:Show();
	end
end


