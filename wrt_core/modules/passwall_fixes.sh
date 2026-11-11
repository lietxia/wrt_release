#!/usr/bin/env bash
apply_passwall_rules_tweaks() {
    local chnlist_path="$(get_custom_feed_worktree_dir)/luci-app-passwall/root/usr/share/passwall/rules/chnlist"
    if [ -f "$chnlist_path" ]; then
        >"$chnlist_path"
    fi
}


apply_passwall_xray_tweaks() {
    local xray_util_path="$(get_custom_feed_worktree_dir)/luci-app-passwall/luasrc/passwall/util_xray.lua"
    if [ -f "$xray_util_path" ]; then
        sed -i 's/maxRTT = "1s"/maxRTT = "2s"/g' "$xray_util_path"
        sed -i 's/sampling = 3/sampling = 5/g' "$xray_util_path"
    fi
}


apply_passwall_fixes() {
    apply_passwall_rules_tweaks || return 1
    apply_passwall_xray_tweaks || return 1
}
