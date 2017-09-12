
update AT_TreeNodes set NodeName = 'List of Assets By Category', NodeNavigateLink = 'AssetManagement/AssetListByCategory'
where NodeId = 20140

Insert Into AT_TreeNodes(NodeName
, NodeNavigateLink
,PageExtension
,ParentID
,SortingOrder
,IsQueryString
,IsModule
,ModifiedDate)
Select
'List Of Asset'
,'AssetManagement/AssetList'
,'aspx'
,20139
,201398
,'False'
,'False'
,GetDate()