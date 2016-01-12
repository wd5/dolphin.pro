
-- Options

SET @iMaxOrder = (SELECT `menu_order` + 1 FROM `sys_options_cats` ORDER BY `menu_order` DESC LIMIT 1);
INSERT INTO `sys_options_cats` (`name`, `menu_order`) VALUES ('WebRTC Chat', @iMaxOrder);
SET @iKategId = (SELECT LAST_INSERT_ID());

INSERT INTO  `sys_options` SET `Name` = 'bx_chat_webrtc_url', `kateg` = @iKategId, `desc` = 'Chat URL', `Type` = 'digit', `VALUE` = '', `order_in_kateg` = 10;

INSERT INTO  `sys_options`  (`Name`, `VALUE`, `kateg`, `desc`, `Type`, `check`, `err_text`, `order_in_kateg`, `AvailableValues`)  VALUES
('bx_chat_webrtc_permalinks', 'on', 26, 'Enable friendly permalinks in WebRTC Chat', 'checkbox', '', '', '0', '');

-- Menu Admin

SET @iOrder = (SELECT MAX(`order`) FROM `sys_menu_admin` WHERE `parent_id` = '2');

INSERT INTO  `sys_menu_admin`  SET `name` = 'WebRTC Chat', `title` = '_bx_chat_webrtc', `url` = '{siteUrl}modules/?r=chat_webrtc/administration/',  `description` = 'Managing the \'WebRTC Chat\' settings', `icon` = 'commenting', `parent_id` = 2, `order` = @iOrder+1;

-- Permalinks

INSERT INTO  `sys_permalinks` SET `standard` = 'modules/?r=chat_webrtc/', `permalink` = 'm/chat_webrtc/', `check` = 'bx_chat_webrtc_permalinks';

-- Main Menu

SET @iOrder := (SELECT MAX(`Order`) FROM `sys_menu_top` WHERE `Parent` = '0');
INSERT INTO `sys_menu_top` (`Parent`, `Name`, `Caption`, `Link`, `Order`, `Visible`, `Target`, `Onclick`, `Check`, `Editable`, `Deletable`, `Active`, `Type`, `Picture`, `BQuickLink`, `Statistics`) VALUES
(0, 'WebRTC Chat', '_bx_chat_webrtc_chat', 'modules/?r=chat_webrtc/redirect/', @iOrder+1, 'non,memb', '_blank', '', '', 1, 1, 1, 'top', 'commenting', 0, '');

