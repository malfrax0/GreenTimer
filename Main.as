
bool Done = false;

[Setting name="Chrono color" color]
vec3 textColor(1.0, 1.0, 1.0);

bool IsOnGame() {
    CTrackMania@ App = cast<CTrackMania@>(GetApp());

    return App.Editor is null &&
            App.RootMap !is null &&
            App.CurrentPlayground !is null &&
            App.Network !is null &&
            App.Network.ClientManiaAppPlayground !is null;
}

void Update(float dt) {
    if (Done) {
        if (!IsOnGame()) {
            Done = false;
        }
        return;
    }
    if (IsOnGame()) {  
        CTrackMania@ App = cast<CTrackMania@>(GetApp());
        
        CGameManiaAppPlayground@ CMAP;
        try { @CMAP = App.Network.ClientManiaAppPlayground; } catch { }
        for (uint i = 0; i < CMAP.UILayers.Length; i++) {    
            CGameUILayer@ Layer = CMAP.UILayers[i];
            if (Layer is null) {
                continue;
            }
            string Page = string(Layer.ManialinkPage).Trim().SubStr(26, 22);
            
            if (Page.StartsWith("Race_Chrono")) {
                CGameManialinkLabel@ Label = cast<CGameManialinkLabel@>(Layer.LocalPage.GetFirstChild("label-chrono"));
                if (Label is null) {
                    warn("Did not find the chrono label.");
                }
                else {
                    Label.TextColor = textColor;
                }
                Done = true;
                break;
            }
        }
    }
}

void OnSettingsChanged() {
    Done = false;
}