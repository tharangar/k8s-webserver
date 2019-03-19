// ag-grid-enterprise v13.2.0
import { BeanStub, IEnterpriseDatasource, IEnterpriseRowModel, RowNode, RowBounds } from "ag-grid";
export declare class EnterpriseRowModel extends BeanStub implements IEnterpriseRowModel {
    private gridOptionsWrapper;
    private eventService;
    private context;
    private columnController;
    private filterManager;
    private sortController;
    private gridApi;
    private columnApi;
    private rootNode;
    private datasource;
    private rowHeight;
    private cacheParams;
    private logger;
    private rowNodeBlockLoader;
    private postConstruct();
    private setBeans(loggerFactory);
    isLastRowFound(): boolean;
    private addEventListeners();
    private onFilterChanged();
    private onSortChanged();
    private onValueChanged();
    private onColumnRowGroupChanged();
    private onColumnPivotChanged();
    private onPivotModeChanged();
    private onRowGroupOpened(event);
    private reset();
    private createNewRowNodeBlockLoader();
    private destroyRowNodeBlockLoader();
    setDatasource(datasource: IEnterpriseDatasource): void;
    private toValueObjects(columns);
    private createCacheParams();
    private createNodeCache(rowNode);
    private onCacheUpdated();
    updateRowIndexesAndBounds(): void;
    private setDisplayIndexes(cache);
    private resetRowTops(cache);
    getRow(index: number): RowNode;
    getPageFirstRow(): number;
    getPageLastRow(): number;
    getRowCount(): number;
    getRowBounds(index: number): RowBounds;
    getRowIndexAtPixel(pixel: number): number;
    getCurrentPageHeight(): number;
    isEmpty(): boolean;
    isRowsToRender(): boolean;
    getType(): string;
    forEachNode(callback: (rowNode: RowNode) => void): void;
    purgeCache(route?: string[]): void;
    getNodesInRangeForSelection(firstInRange: RowNode, lastInRange: RowNode): RowNode[];
    getBlockState(): any;
    isRowPresent(rowNode: RowNode): boolean;
}
