--!strict

-- Core type aliases
export type WorldFilterQueryFunc = (
	item: any,
	other: any,
	shape: CollisionShape,
	otherShape: CollisionShape
) -> string | WorldVisitFunc | false
export type WorldShapeFilterQueryFunc = (item: any, shape: CollisionShape) -> boolean
export type WorldResponseFunc = (
	world: World,
	query: WorldQuery,
	response: WorldQueryResponse,
	previousResponse: WorldQueryResponse,
	x: number,
	y: number,
	goalX: number,
	goalY: number,
	filter: WorldFilterQueryFunc,
	result: WorldQuery
) -> (number, number, number, number, string?, WorldQueryResponse)
export type WorldVisitFunc = (
	item: any,
	world: World,
	query: WorldQuery,
	response: WorldQueryResponse,
	x: number,
	y: number,
	goalX: number,
	goalY: number
) -> string

-- Core Options type
export type Options = {
	epsilon: number?,
	maxBounces: number?,
	maxJitter: number?,
	debug: boolean?,
	quadTreeX: number?,
	quadTreeY: number?,
	quadTreeMaxLevels: number?,
	quadTreeMaxData: number?,
	quadTreeExpand: boolean?,
	quadTreeOptimizationMargin: number?,
	sharedCache: Cache?,
}

-- Cache type
export type Cache = typeof(setmetatable(
	{} :: {
		triangulator: any,
	},
	{} :: CacheImpl
))

type CacheImpl = {
	__index: CacheImpl,
	new: (options: Options) -> Cache,
}

-- Tag type
export type Tag = typeof(setmetatable(
	{} :: {
		value: any,
	},
	{} :: TagImpl
))

type TagImpl = {
	__index: TagImpl,
	new: (value: any) -> Tag,
}

-- Enum type
export type Enum = typeof(setmetatable(
	{} :: {
		value: any,
	},
	{} :: EnumImpl
))

type EnumImpl = {
	__index: EnumImpl,
	new: (value: any) -> Enum,
}

-- Geometry types
export type Point = typeof(setmetatable(
	{} :: {
		x: number,
		y: number,
	},
	{} :: PointImpl
))

type PointImpl = {
	__index: PointImpl,
	new: (x: number?, y: number?) -> Point,
	init: (self: Point, x: number, y: number) -> (),
	compare: (a: Point, b: Point) -> number,
	less: (a: Point, b: Point) -> boolean,
	higher: (self: Point, other: Point) -> Point,
	lower: (self: Point, other: Point) -> Point,
	equal: (self: Point, other: Point) -> boolean,
	notEqual: (self: Point, other: Point) -> boolean,
	greaterThan: (self: Point, other: Point) -> boolean,
	greaterThanEqual: (self: Point, other: Point) -> boolean,
	lessThan: (self: Point, other: Point) -> boolean,
	lessThanOrEqual: (self: Point, other: Point) -> boolean,
	direction: (self: Point, other: Point, result: Point?) -> Point,
	left: (self: Point, other: Point) -> number,
	right: (self: Point, other: Point) -> number,
	dot: (self: Point, other: Point) -> number,
	add: (self: Point, other: Point, result: Point?) -> Point,
	addScalar: (self: Point, scalar: number, result: Point?) -> Point,
	sub: (self: Point, other: Point, result: Point?) -> Point,
	subScalar: (self: Point, scalar: number, result: Point?) -> Point,
	multiply: (self: Point, other: Point, result: Point?) -> Point,
	multiplyScalar: (self: Point, scalar: number, result: Point?) -> Point,
	divide: (self: Point, other: Point, result: Point?) -> Point,
	divideScalar: (self: Point, scalar: number, result: Point?) -> Point,
	length: (self: Point) -> number,
	distance: (self: Point, other: Point) -> number,
	normalize: (self: Point, result: Point?) -> Point,
	copy: (self: Point, result: Point?) -> Point,
}

export type Rectangle = typeof(setmetatable(
	{} :: {
		topLeft: Point,
		bottomRight: Point,
	},
	{} :: RectangleImpl
))

type RectangleImpl = {
	__index: RectangleImpl,
	new: (x1: number?, y1: number?, x2: number?, y2: number?) -> Rectangle,
	init: (self: Rectangle, x1: number?, y1: number?, x2: number?, y2: number?) -> (),
	left: (self: Rectangle) -> number,
	right: (self: Rectangle) -> number,
	top: (self: Rectangle) -> number,
	bottom: (self: Rectangle) -> number,
	width: (self: Rectangle) -> number,
	height: (self: Rectangle) -> number,
	expand: (self: Rectangle, x: number, y: number) -> (),
	move: (self: Rectangle, x: number, y: number) -> (),
	sweep: (self: Rectangle, x: number, y: number) -> (),
	overlaps: (self: Rectangle, other: Rectangle) -> boolean,
	inside: (self: Rectangle, p: Point, E: number?) -> boolean,
}

export type Segment = typeof(setmetatable(
	{} :: {
		a: Point,
		b: Point,
	},
	{} :: SegmentImpl
))

type SegmentImpl = {
	__index: SegmentImpl,
	new: (x1: number?, y1: number?, x2: number?, y2: number?) -> Segment,
	init: (self: Segment, x1: number?, y1: number?, x2: number?, y2: number?) -> (),
	length: (self: Segment) -> number,
	direction: (self: Segment, result: Point?) -> Point,
	normal: (self: Segment, result: Point?) -> Point,
	closestPoint: (self: Segment, p: Point, result: Point?) -> Point,
	distance: (self: Segment, p: Point) -> number,
}

export type Ray = typeof(setmetatable(
	{} :: {
		position: Point,
		direction: Point,
	},
	{} :: RayImpl
))

type RayImpl = {
	__index: RayImpl,
	new: (x: number?, y: number?, dx: number?, dy: number?) -> Ray,
	init: (self: Ray, x: number?, y: number?, dx: number?, dy: number?) -> (),
	at: (self: Ray, t: number, result: Point?) -> Point,
}

export type Transform = typeof(setmetatable(
	{} :: {
		x: number,
		y: number,
		rotation: number,
		scaleX: number,
		scaleY: number,
		offsetX: number,
		offsetY: number,
	},
	{} :: TransformImpl
))

type TransformImpl = {
	__index: TransformImpl,
	new: (
		x: number?,
		y: number?,
		rotation: number?,
		scaleX: number?,
		scaleY: number?,
		offsetX: number?,
		offsetY: number?
	) -> Transform,
	setTransform: (
		self: Transform,
		x: number?,
		y: number?,
		rotation: number?,
		scaleX: number?,
		scaleY: number?,
		offsetX: number?,
		offsetY: number?
	) -> (),
	copy: (self: Transform, result: Transform?) -> Transform,
	invert: (self: Transform, result: Transform?) -> Transform,
	combine: (self: Transform, other: Transform, result: Transform?) -> Transform,
	transformPoint: (self: Transform, point: Point, result: Point?) -> Point,
	transformPointInverse: (self: Transform, point: Point, result: Point?) -> Point,
}

-- Collision types
export type CollisionShape = typeof(setmetatable(
	{} :: {
		tag: any,
		entity: Entity,
		vertexCount: number,
		normalCount: number,
		center: Point,
		vertices: { Point },
		bounds: Rectangle,
		normals: { Point },
	},
	{} :: CollisionShapeImpl
))

type CollisionShapeImpl = {
	__index: CollisionShapeImpl,
	new: (entity: Entity | Cache) -> CollisionShape,
	init: (self: CollisionShape) -> (),
	addPoints: (self: CollisionShape, x1: number?, y1: number?, ...number?) -> (),
	addNormal: (self: CollisionShape, x: number, y: number) -> (),
	inside: (self: CollisionShape, p: Point) -> boolean,
	buildNormals: (self: CollisionShape) -> (),
	transform: (self: CollisionShape, transform: Transform) -> (),
	getAxes: (self: CollisionShape, query: any) -> (),
	project: (self: CollisionShape, query: any, axis: Point, interval: any, offset: Point) -> (),
	distance: (self: CollisionShape, p: Point) -> number,
	raycast: (self: CollisionShape, r: Ray, normal: Point?) -> number,
}

export type ShapeDefinition = {
	type: { new: (entity: Entity | Cache, ...any) -> any },
	n: number,
	tag: Tag?,
	arguments: { any },
}

export type ShapeGroup = typeof(setmetatable(
	{} :: {
		tag: any,
		entity: Entity | Cache,
		shapes: { CollisionShape },
	},
	{} :: ShapeGroupImpl
))

type ShapeGroupImpl = {
	__index: ShapeGroupImpl,
	new: (entity: Entity | Cache, tag: (Tag | Enum)?, ...ShapeDefinition) -> ShapeGroup,
	attach: (self: ShapeGroup) -> (),
	detach: (self: ShapeGroup) -> (),
}

-- QuadTree types
export type QuadTreeOptions = {
	x: number?,
	y: number?,
	width: number?,
	height: number?,
	maxLevels: number?,
	maxData: number?,
	expand: boolean?,
}

export type QuadTree = typeof(setmetatable(
	{} :: {
		root: any,
		expand: boolean,
		bounds: Rectangle,
		maxLevels: number,
		maxData: number,
	},
	{} :: QuadTreeImpl
))

type QuadTreeImpl = {
	__index: QuadTreeImpl,
	new: (options: QuadTreeOptions?) -> QuadTree,
	update: (self: QuadTree, item: any, bounds: Rectangle) -> (),
	remove: (self: QuadTree, item: any) -> (),
	has: (self: QuadTree, item: any) -> boolean,
	rebuild: (self: QuadTree, options: QuadTreeOptions) -> (),
	computeExactBounds: (self: QuadTree) -> Rectangle,
}

-- Entity type
export type Entity = typeof(setmetatable(
	{} :: {
		item: any?,
		world: World?,
		bounds: Rectangle,
		shapes: ShapeGroup,
		transform: Transform,
	},
	{} :: EntityImpl
))

type EntityImpl = {
	__index: EntityImpl,
	new: () -> Entity,
	init: (self: Entity, item: any) -> (),
	setShapes: (self: Entity, ...ShapeDefinition) -> (),
	setTransform: (self: Entity, transform: Transform) -> (),
	add: (self: Entity, world: World) -> (),
	detach: (self: Entity) -> (),
}

-- World Query types
export type WorldQueryResponse = typeof(setmetatable(
	{} :: {
		query: WorldQuery,
		response: string | WorldVisitFunc | true,
		item: any,
		entity: Entity,
		shape: CollisionShape,
		other: any?,
		otherEntity: Entity?,
		otherShape: CollisionShape?,
		normal: Point,
		depth: number,
		time: number,
		offset: Point,
		touch: Point,
		isProjection: boolean,
		contactPoint: Point,
		contactPoints: { Point },
		segment: Segment,
		distance: number,
		extra: { [any]: any },
	},
	{} :: WorldQueryResponseImpl
))

type WorldQueryResponseImpl = {
	__index: WorldQueryResponseImpl,
	new: (query: WorldQuery) -> WorldQueryResponse,
	init: (
		self: WorldQueryResponse,
		shape: CollisionShape,
		otherShape: CollisionShape?,
		response: any,
		position: Point,
		query: any
	) -> (),
	less: (a: WorldQueryResponse, b: WorldQueryResponse) -> boolean,
}

export type WorldQuery = typeof(setmetatable(
	{} :: {
		world: World,
		results: { WorldQueryResponse },
	},
	{} :: WorldQueryImpl
))

type WorldQueryImpl = {
	__index: WorldQueryImpl,
	new: (world: World) -> WorldQuery,
	reset: (self: WorldQuery) -> (),
	sort: (self: WorldQuery) -> (),
}

-- World type
export type World = typeof(setmetatable(
	{} :: {
		cache: Cache,
		quadTree: QuadTree,
		options: Options,
		quadTreeOptions: QuadTreeOptions,
		responses: { [string]: WorldResponseFunc },
		entities: { Entity },
		itemToEntity: { [any]: number },
		previousEntityCollisions: { [Entity]: WorldQuery },
		freeWorldQueries: { WorldQuery },
		freeList: { number },
		cachedQuery: WorldQuery,
		cachedPushQuery: WorldQuery,
	},
	{} :: WorldImpl
))

type WorldImpl = {
	__index: WorldImpl,
	new: (width: number, height: number, options: Options?) -> World,
	add: ((self: World, item: any) -> Entity)
		& ((self: World, item: any, x: number, y: number, shape: ShapeDefinition) -> Entity)
		& ((self: World, item: any, transform: Transform, shape: ShapeDefinition) -> Entity),
	get: (self: World, item: any) -> Entity,
	getItems: (self: World, items: { any }?) -> { any },
	has: (self: World, item: any) -> boolean,
	remove: (self: World, item: any) -> (),
	update: ((self: World, item: any, x: number, y: number, shape: ShapeDefinition?) -> (number, number))
		& ((self: World, item: any, transform: Transform, shape: ShapeDefinition?) -> (number, number)),
	move: (
		self: World,
		item: any,
		goalX: number,
		goalY: number,
		filter: WorldFilterQueryFunc?
	) -> (number, number, { WorldQueryResponse }, number),
	check: (
		self: World,
		item: any,
		goalX: number,
		goalY: number,
		filter: WorldFilterQueryFunc?
	) -> (number, number, { WorldQueryResponse }, number),
	project: (
		self: World,
		item: any,
		x: number,
		y: number,
		goalX: number,
		goalY: number,
		filter: WorldFilterQueryFunc?,
		query: WorldQuery?
	) -> ({ WorldQueryResponse }, number),
	queryRectangle: (
		self: World,
		x: number,
		y: number,
		w: number,
		h: number,
		filter: WorldShapeFilterQueryFunc?
	) -> ({ any }, number),
	queryPoint: (self: World, x: number, y: number, filter: WorldShapeFilterQueryFunc?) -> ({ any }, number),
	querySegment: (
		self: World,
		x1: number,
		y1: number,
		x2: number,
		y2: number,
		filter: WorldShapeFilterQueryFunc?
	) -> ({ any }, number),
	queryRay: (
		self: World,
		x: number,
		y: number,
		dx: number,
		dy: number,
		filter: WorldShapeFilterQueryFunc?
	) -> ({ any }, number),
	addResponse: (self: World, name: string, response: WorldResponseFunc) -> (),
	removeResponse: (self: World, name: string) -> (),
	getResponse: (self: World, name: string) -> WorldResponseFunc,
	resize: (self: World, x: number, y: number, width: number, height: number) -> (),
}

-- Navigation types
export type NavigationVertex = typeof(setmetatable(
	{} :: {
		point: Point,
		userdata: any,
		index: number,
	},
	{} :: NavigationVertexImpl
))

type NavigationVertexImpl = {
	__index: NavigationVertexImpl,
	new: (point: Point, userdata: any, index: number) -> NavigationVertex,
}

export type NavigationEdge = typeof(setmetatable(
	{} :: {
		a: NavigationVertex,
		b: NavigationVertex,
		min: number,
		max: number,
	},
	{} :: NavigationEdgeImpl
))

type NavigationEdgeImpl = {
	__index: NavigationEdgeImpl,
	new: (a: NavigationVertex, b: NavigationVertex) -> NavigationEdge,
	same: (self: NavigationEdge, other: NavigationEdge) -> boolean,
	compare: (a: NavigationEdge, b: NavigationEdge) -> number,
	less: (a: NavigationEdge, b: NavigationEdge) -> boolean,
}

export type NavigationTriangle = typeof(setmetatable(
	{} :: {
		a: NavigationVertex,
		b: NavigationVertex,
		c: NavigationVertex,
	},
	{} :: NavigationTriangleImpl
))

type NavigationTriangleImpl = {
	__index: NavigationTriangleImpl,
	new: (a: NavigationVertex, b: NavigationVertex, c: NavigationVertex) -> NavigationTriangle,
}

export type NavigationMesh = typeof(setmetatable(
	{} :: {
		vertices: { NavigationVertex },
		edges: { NavigationEdge },
		triangles: { NavigationTriangle },
	},
	{} :: NavigationMeshImpl
))

type NavigationMeshImpl = {
	__index: NavigationMeshImpl,
	new: (points: { number }, userdata: { any }?, edges: { number }?) -> NavigationMesh,
}

export type NavigationPathOptions = {
	neighbor: ((self: NavigationPath, a: NavigationVertex, b: NavigationVertex, edge: NavigationEdge) -> boolean)?,
}

export type NavigationPath = typeof(setmetatable(
	{} :: {
		neighbor: ((self: NavigationPath, a: NavigationVertex, b: NavigationVertex, edge: NavigationEdge) -> boolean)?,
	},
	{} :: NavigationPathImpl
))

type NavigationPathImpl = {
	__index: NavigationPathImpl,
	new: (options: NavigationPathOptions?) -> NavigationPath,
	find: (self: NavigationPath, mesh: NavigationMesh, start: Point, goal: Point) -> { NavigationVertex } | false,
}

export type NavigationMeshBuilder = typeof(setmetatable(
	{} :: {
		layers: { any },
	},
	{} :: NavigationMeshBuilderImpl
))

type NavigationMeshBuilderImpl = {
	__index: NavigationMeshBuilderImpl,
	new: () -> NavigationMeshBuilder,
	addLayer: (self: NavigationMeshBuilder, tag: Tag | Enum) -> (),
	addShape: (self: NavigationMeshBuilder, tag: Tag | Enum, shape: ShapeDefinition, userdata: any) -> (),
	addMesh: (self: NavigationMeshBuilder, tag: Tag | Enum, mesh: NavigationMesh) -> (),
	build: (self: NavigationMeshBuilder, options: any?) -> NavigationMesh,
}

-- Collision system types
export type CollisionInterval = typeof(setmetatable(
	{} :: {
		min: number,
		max: number,
		indexCount: number,
		indices: { { value: number, index: number } },
	},
	{} :: CollisionIntervalImpl
))

type CollisionIntervalImpl = {
	__index: CollisionIntervalImpl,
	new: () -> CollisionInterval,
	init: (self: CollisionInterval) -> (),
}

export type CollisionBox = CollisionShape & {
	-- Inherits from CollisionShape
}

export type CollisionPolygon = CollisionShape & {
	-- Inherits from CollisionShape
}

export type CollisionLineSegment = CollisionShape & {
	segment: Segment,
}

export type CollisionPolygonMesh = typeof(setmetatable(
	{} :: {
		tag: any,
		entity: Entity,
		boundaries: { { number } },
		polygons: { CollisionPolygon },
		cleanupOptions: any,
		triangulationOptions: any,
	},
	{} :: CollisionPolygonMeshImpl
))

type CollisionPolygonMeshImpl = {
	__index: CollisionPolygonMeshImpl,
	new: (entity: Entity, ...{ number }) -> CollisionPolygonMesh,
	build: (self: CollisionPolygonMesh, triangulator: any) -> (),
}

export type CollisionQuadTreeNode = typeof(setmetatable(
	{} :: {
		bounds: Rectangle,
		data: { any },
		children: { CollisionQuadTreeNode }?,
		level: number,
	},
	{} :: CollisionQuadTreeNodeImpl
))

type CollisionQuadTreeNodeImpl = {
	__index: CollisionQuadTreeNodeImpl,
	new: (bounds: Rectangle, level: number, maxLevels: number, maxData: number) -> CollisionQuadTreeNode,
}

export type CollisionQuadTreeQuery = typeof(setmetatable(
	{} :: {
		quadTree: QuadTree,
		results: { any },
	},
	{} :: CollisionQuadTreeQueryImpl
))

type CollisionQuadTreeQueryImpl = {
	__index: CollisionQuadTreeQueryImpl,
	new: (quadTree: QuadTree) -> CollisionQuadTreeQuery,
	perform: (self: CollisionQuadTreeQuery, shape: Point | Rectangle | Segment | Ray) -> (),
}

export type CollisionShapeCollisionResolutionQuery = typeof(setmetatable(
	{} :: {
		epsilon: number,
		collision: boolean,
		depth: number,
		normal: Point,
		time: number,
		currentOffset: Point,
		otherOffset: Point,
		contactPointsCount: number,
		contactPoints: { Point },
		segment: Segment,
	},
	{} :: CollisionShapeCollisionResolutionQueryImpl
))

type CollisionShapeCollisionResolutionQueryImpl = {
	__index: CollisionShapeCollisionResolutionQueryImpl,
	new: (E: number?) -> CollisionShapeCollisionResolutionQuery,
	performProjection: (
		self: CollisionShapeCollisionResolutionQuery,
		shape: CollisionShape,
		otherShape: CollisionShape,
		currentOffset: Point,
		otherOffset: Point,
		currentVelocity: Point,
		otherVelocity: Point
	) -> (),
}

-- Utility types
export type UtilPool = typeof(setmetatable(
	{} :: {
		type: any,
		used: { [any]: boolean },
		free: { any },
	},
	{} :: UtilPoolImpl
))

type UtilPoolImpl = {
	__index: UtilPoolImpl,
	new: (poolType: any) -> UtilPool,
	remove: (self: UtilPool, value: any) -> boolean,
	add: (self: UtilPool, value: any) -> boolean,
	allocate: (self: UtilPool, ...any) -> any,
	free: (self: UtilPool, value: any) -> boolean,
	reset: (self: UtilPool) -> (),
}

export type UtilSearch = {
	compareResult: number, -- -1, 0, or 1
}

-- Geometry types
export type GeometrySimpleClipOperation = {
	clipType: string,
	subjectContour: { number },
	clipContour: { number },
}

export type GeometryClipper = typeof(setmetatable(
	{} :: {
		epsilon: number,
		debug: boolean,
	},
	{} :: GeometryClipperImpl
))

type GeometryClipperImpl = {
	__index: GeometryClipperImpl,
	new: (options: GeometryClipperClipOptions?) -> GeometryClipper,
	clip: (
		self: GeometryClipper,
		subject: { number },
		clip: { number },
		operation: string,
		triangulator: any
	) -> { { number } },
}

export type GeometryClipperClipOptions = {
	epsilon: number?,
	debug: boolean?,
	refine: boolean?,
	interior: boolean?,
	exterior: boolean?,
	polygonization: boolean?,
}

export type GeometryMerge = {
	contours: { { number } },
}

-- Triangulation types
export type TriangulationEdge = typeof(setmetatable(
	{} :: {
		a: Point,
		b: Point,
		index: number,
	},
	{} :: TriangulationEdgeImpl
))

type TriangulationEdgeImpl = {
	__index: TriangulationEdgeImpl,
	new: (a: Point, b: Point, index: number?) -> TriangulationEdge,
}

export type TriangulationDelaunayOptions = {
	epsilon: number?,
	debug: boolean?,
}

export type TriangulationDelaunayTriangulationOptions = {
	refine: boolean?,
	interior: boolean?,
	exterior: boolean?,
	polygonization: boolean?,
}

export type TriangulationDelaunayCleanupOptions = {
	epsilon: number?,
	debug: boolean?,
}

export type TriangulationDelaunay = typeof(setmetatable(
	{} :: {
		epsilon: number,
		debug: boolean,
		sweepline: any,
		hull: any,
	},
	{} :: TriangulationDelaunayImpl
))

type TriangulationDelaunayImpl = {
	__index: TriangulationDelaunayImpl,
	new: (options: TriangulationDelaunayOptions?) -> TriangulationDelaunay,
	triangulate: (
		self: TriangulationDelaunay,
		contours: { { number } },
		options: TriangulationDelaunayTriangulationOptions?
	) -> { { number } },
	cleanup: (
		self: TriangulationDelaunay,
		contours: { { number } },
		options: TriangulationDelaunayCleanupOptions?
	) -> { { number } },
}

export type TriangulationSortedPoint = {
	point: Point,
	index: number,
}

export type TriangulationSortedEdge = {
	edge: TriangulationEdge,
	index: number,
}

export type TriangulationHull = {
	points: { Point },
}

export type TriangulationIntersection = {
	point: Point,
	edges: { TriangulationEdge },
}

export type TriangulationDissolve = {
	userdata: any,
	otherUserdata: any,
	resultUserdata: any,
}

export type TriangulationSweep = {
	events: { any },
	active: { any },
}

-- Drawing types
export type DrawOptions = {
	normals: boolean?,
	text: boolean?,
	queries: { { shape: Point | Rectangle | Segment | Ray, filter: WorldShapeFilterQueryFunc? } }?,
}

-- Response system aliases
export type ResponseSlide = WorldResponseFunc
export type ResponseTouch = WorldResponseFunc
export type ResponseCross = WorldResponseFunc
export type ResponseBounce = WorldResponseFunc

-- Important type aliases from collision system
export type CollisionShapeInterface = CollisionShape
export type CollisionShapelike = CollisionShape | ShapeGroup | CollisionShapeInterface | CollisionPolygonMesh

-- Geometric shape union types
export type GeometryShape = Point | Ray | Rectangle | Segment

return {}
