extends ItemList

func _on_ItemList_item_selected(index):
	print_debug("is selected?: ", is_selected(index))
	if is_selected(index):
		unselect(index)
	else:
		select(index)


func _on_ItemList_nothing_selected():
	unselect_all()
