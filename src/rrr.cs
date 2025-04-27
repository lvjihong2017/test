private void SendSocketMessage(string strContent, string sendType)
{
if (sendType!=“1” || sendType !="3")
{
return;
};

CreatSelfChatItem(strContent):SwitchThinking(isThink:true),CreatThinking();

}