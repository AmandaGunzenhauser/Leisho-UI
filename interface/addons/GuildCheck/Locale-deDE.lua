﻿local L = LibStub("AceLocale-3.0"):NewLocale("GuildCheck", "deDE", false)

if not L then return end

-- Options
L["Use GUI"] = "GUI verwenden"
L["Defines whether the changes are diplayed in the chat or in the GUI on login."] = "Bestimmt, ob die Änderungen im Chat oder in der GUI beim Einloggen angezeigt werden."
L["Output/Display only on changes"] = "Ausgabe/GUI nur bei Änderungen zeigen"
L["Show Text/GUI only if changes occurred."] = "Die Text Ausgabe/GUI soll nur angezeigt werden, wenn mindestens eine Änderung aufgetreten ist."
L["Delay"] = "Verzögerung"
L["Defines the seconds after login until the changes are reported."] = "Gibt an, wie viele Sekunden nach dem Einloggen gewartet wird, bis die Änderungen ausgegeben werden."
L["<Seconds>"] = "<Sekunden>"
L["Show GUI"] = "Zeige GUI"
L["Shows a frame where you can display and copy changes."] = "Zeigt ein Fenster mit den Änderungen, die auch kopiert werden können."
L["Show Offline Changes"] = "Zeige Offline Veränderungen"
L["Offline"] = "Offline"
L["Shows changes since last session."] = "Zeigt die Änderungen seit der letzten Sitzung."
L["Show Online Changes"] = "Zeige Online Veränderungen"
L["Shows changes during this session."] = "Zeigt die Änderungen in dieser Sitzung."
L["Online"] = "Online"
L["Open Config"] = "Konfiguration öffnen"
L["Opens a graphical configuration."] = "Öffnet eine graphische Konfiguration."
L["Exit"] = "Schliessen"
L["Shows changes in your guild since your last time online."] = "Zeigt Veränderungen in der Gilde seit dem letzten Mal online sein."
L["Display"] = "Anzeige"
L["Defines what kind of changes will be shown."] = "Welche Änderungen sollen angezeigt werden."
L["Show Promotes/Demotes"] = "Zeige Beförderungen/Degradierungen"
L["Show Level Ups"] = "Zeige Stufenanstiege"
L["Show Note Changes"] = "Zeige Notizänderungen"
L["Show Officernote Changes"] = "Zeige Änderungen an der Offiziersnotiz"
L["Members join"] = "Beitritte"
L["Show if someone has joined the guild."] = "Zeigt, wenn jemand der Gilde beigetreten ist."
L["Members leave"] = "Austritte"
L["Show if someone has left the guild."] = "Zeigt, wenn jemand die Gilde verlassen hat."
L["Use Guild Log"] = "Verwende Gildenlog"
L["Use Data from the Guild Log to show who has invited, promoted, demoted or kicked players.\n\n|cffff0000The output can lag a bit.|r"] = "Verwende das Gildenlog, um anzuzeigen, wer einen Spieler eingeladen, befördert, degradiert oder rausgeschmissen hat.\n\n|cffff0000Die Ausgabe kann sich etwas verzögern.|r"
L["Change Output Channel to Whisper"] = ""
L["Defines whether the changes are diplayed in the default Chat or Whisper to Player."] = ""   
L["Minimap Button"] = "" 
L["Hides Minimap Button."] = ""  


 
-- Output
L["has left the guild"] = "hat die Gilde verlassen"
L["was removed by %s"] = "wurde von %s entfernt"
L["has joined the guild"] = "hat sich der Gilde angeschlossen"
L["has joined the guild (invited by %s)"] = "hat sich der Gilde angeschlossen (eingeladen von %s)"
L["was promoted by %s"] = "wurde von %s befördert"
L["was demoted by %s"] = "wurde von %s degradiert"
L["Rank"] = "Rang"
L["Level"] = "Stufe"
L["Class"] = "Klasse"
L["Note"] = "Notiz"
L["Officernote"] = "Offiziersnotiz"
L["Initial scan done."] = "Initialscan abgeschlossen."
L["The guild '%s' has been deleted."] = "Die Gilde '%s' wurde gelöscht."
L["Total: %d changes"] = "Insgesamt: %d Änderungen"
L["Total: 1 change"] = "Insgesamt: 1 Änderung"
L["no changes found"] = "Keine Änderungen gefunden"
L["Data upgraded to version %s!"] = "Daten für Version %s aktualisiert!"
	
-- Dialog
L["It seems that your last character has left this guild.\nDo you want to delete the data that GuildCheck has saved for this guild?"] = "Es scheint so, als hättest Du mit Deinem letzten Charakter diese Gilde verlassen.\nSollen die von GuildCheck für diese Gilde gespeicherten Daten gelöscht werden?"
L["Your GuildCheck Data needs a conversion! This process is not reversible.\nYou can choose 'No' and backup your SavedVariables folder.\nGuildCheck won't work as long as you don't convert the data.\n\nDo you want to convert the data now?"] = "Deine GuildCheck Daten müssen konvertiert werden! Dieser Prozess ist nicht umkehrbar.\nDu kannst 'Nein' wählen und Deinen SavedVariables Ordner sichern.\nGuildCheck wird solange nicht funktionieren, bis die Daten konvertiert wurden.\n\nMöchtest Du die Daten jetzt konvertieren?"
L["Yes"] = "Ja"
L["No"] = "Nein"