#!/bin/bash
# Patch: Customize LuCI footer to show "by Lean ... for Ungelivable Team"
# Usage: bash apply.sh (from openwrt root directory)

THEME_DIR="feeds/luci/themes"

# Bootstrap footer
cat > "$THEME_DIR/luci-theme-bootstrap/ucode/template/themes/bootstrap/footer.ut" << 'ENDFOOTER'
		{% if (!blank_page): %}
		</div>
		<footer>
			<span>
				by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer">{{ version.distname }} {{ version.distversion }} ({{ version.distrevision }})</a> for Ungelivable Team
			</span>
			<ul class="breadcrumb pull-right" id="modemenu" style="display:none"></ul>
		</footer>
		<script type="text/javascript">L.require("menu-bootstrap")</script>
		{% endif %}
	</body>
</html>
ENDFOOTER

# Material footer
cat > "$THEME_DIR/luci-theme-material/ucode/template/themes/material/footer.ut" << 'ENDFOOTER'
<div class="app-footer">
	<div class="footer-left">
		<span class="footer-bubble">
			by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer">{{ version.distname }} {{ version.distversion }} ({{ version.distrevision }})</a> for Ungelivable Team
		</span>
	</div>
</div>
</body>
</html>
ENDFOOTER

# OpenWrt-2020 footer
cat > "$THEME_DIR/luci-theme-openwrt-2020/ucode/template/themes/openwrt2020/footer.ut" << 'ENDFOOTER'
{#
 Copyright 2020 Jo-Philipp Wich <jo@mein.io>
 Licensed to the public under the Apache License 2.0.
-#}

</div>
</div>

<p class="luci">
	by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer">{{ version.distname }} {{ version.distversion }} ({{ version.distrevision }})</a> for Ungelivable Team
</p>

<script type="text/javascript">L.require("menu-openwrt2020")</script>

</body>
</html>
ENDFOOTER

# OpenWrt.org footer
cat > "$THEME_DIR/luci-theme-openwrt/luasrc/view/themes/openwrt.org/footer.htm" << 'ENDFOOTER'
<%#
 Copyright 2008 Steven Barth <steven@midlink.org>
 Copyright 2008 Jo-Philipp Wich <jow@openwrt.org>
 Licensed to the public under the Apache License 2.0.
-%>

<div class="clear"></div>
</div>
</div>

<p class="luci">
	by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer"><%= ver.distname %> <%= ver.distversion %> (<%= ver.distrevision %>)</a> for Ungelivable Team
</p>

<script type="text/javascript">L.require("menu-openwrt")</script>

</body>
</html>
ENDFOOTER

# Design footer
cat > "$THEME_DIR/luci-theme-design/luasrc/view/themes/design/footer.htm" << 'ENDFOOTER'
<%#
	Material is a clean HTML5 theme for LuCI.
	Licensed to the public under the Apache License 2.0
-%>

<% local ver = require "luci.version" %>
					</div>
					<footer class="mobile-hide">
						by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer"><%= ver.distname %> <%= ver.distversion %> (<%= ver.distrevision %>)</a> for Ungelivable Team
					</footer>
				</div>
			</div>
			<script type="text/javascript">L.require("menu-design")</script>
		</body>
	</html>
ENDFOOTER

# Argon footer (full file)
cat > "$THEME_DIR/luci-theme-argon/luasrc/view/themes/argon/footer.htm" << 'ENDFOOTER'
<%#
	Argon is a clean HTML5 theme for LuCI.
	Copyright 2020 Jerrykuku <jerrykuku@qq.com>
	Licensed to the public under the Apache License 2.0
-%>

<% local ver = require "luci.version" %>
</div>
<footer class="mobile-hide">
	<div>
		by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer"><%= ver.distname %> <%= ver.distversion %> (<%= ver.distrevision %>)</a> for Ungelivable Team
		<ul class="breadcrumb pull-right" id="modemenu" style="display:none"></ul>
	</div>
</footer>
</div>
</div>
<script>
	var luciLocation = <%= luci.http.write_json(luci.dispatcher.context.path) %>;
	var winHeight = $(window).height();
	$(window).resize(function () {
		var winWidth = $(window).width()
		if(winWidth < 600){
			var newHeight = $(this).height();
			var keyboradHeight = newHeight - winHeight;
			$(".ftc").css("bottom", keyboradHeight + 30);
		}
	})
</script>
<script type="text/javascript">L.require("menu-argon")</script>
</body>
</html>
ENDFOOTER

# Argon footer_login
cat > "$THEME_DIR/luci-theme-argon/luasrc/view/themes/argon/footer_login.htm" << 'ENDFOOTER'
<%#
	Argon is a clean HTML5 theme for LuCI.
	Copyright 2020 Jerrykuku <jerrykuku@qq.com>
	Licensed to the public under the Apache License 2.0
-%>

<% local ver = require "luci.version" %>
</div>
<footer>
	<div>
		by Lean <a href="https://openwrt.org/" target="_blank" rel="noreferrer"><%= ver.distname %> <%= ver.distversion %> (<%= ver.distrevision %>)</a> for Ungelivable Team
	</div>
</footer>
</div>
</div>
<script></script>
</body>
</html>
ENDFOOTER

echo "Footer version patch applied to 6 themes."
