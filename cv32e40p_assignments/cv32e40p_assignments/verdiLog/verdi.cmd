fusaSummary -loaddb -fdb_server "localhost:51650" -fdb_name "default" -campaign \
           "cv32e40p" -tool "All Tools"
verdiDockWidgetDisplay -dock widgetDock_FaultSummaryWnd
verdiDockWidgetDisplay -dock widgetDock_FaultDetailWnd
verdiDockWidgetDisplay -dock widgetDock_FaultSummaryWnd
verdiSetActWin -dock widgetDock_FaultDetailWnd
verdiWindowResize -win $_Verdi_1 "830" "958" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
fusaSummary -tab "hierarchy" -action unselect_all
fusaSummary -tab "hierarchy" -action select -item {tb_top}
fusaSummary -tab "hierarchy" -action doubleclick -item {tb_top}
verdiDockWidgetDisplay -dock widgetDock_FaultDetailWnd
verdiSetActWin -dock widgetDock_FaultSummaryWnd
fusaSummary -tab "hierarchy" -action expand -item {tb_top}
fusaSummary -tab "hierarchy" -action expand -item {tb_top.wrapper_i}
fusaSummary -tab "hierarchy" -action unselect_all
fusaSummary -tab "hierarchy" -action select -item {tb_top.wrapper_i}
fusaSummary -tab "hierarchy" -action expand -item {tb_top.wrapper_i.top_i}
fusaSummary -tab "hierarchy" -action expand -item {tb_top.wrapper_i.top_i.core_i}
fusaSummary -tab "hierarchy" -action expand -item \
           {tb_top.wrapper_i.top_i.core_i.ex_stage_i}
fusaSummary -tab "hierarchy" -action expand -item \
           {tb_top.wrapper_i.top_i.core_i.ex_stage_i.alu_i}
debExit
