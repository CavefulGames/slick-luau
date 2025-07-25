--!strict

local types = require("./types")
local cache = require("@slick/cache") :: types.Cache
local collision = require("@slick/collision") :: {
	quadTree: types.QuadTree,
	quadTreeNode: types.CollisionQuadTreeNode,
	quadTreeQuery: types.CollisionQuadTreeQuery,
	polygon: types.CollisionPolygon,
	shapeCollisionResolutionQuery: types.CollisionShapeCollisionResolutionQuery,
}
local draw = require("@slick/draw") :: ((world: types.World, options: types.DrawOptions?) -> ())?
local entity = require("@slick/entity") :: types.Entity
local enum = require("@slick/enum") :: types.Enum
local geometry = require("@slick/geometry") :: {
	clipper: types.GeometryClipper,
	triangulation: {
		delaunay: types.TriangulationDelaunay,
		delaunaySortedEdge: types.TriangulationSortedEdge,
		delaunaySortedPoint: types.TriangulationSortedPoint,
		dissolve: types.TriangulationDissolve,
		edge: types.TriangulationEdge,
		hull: types.TriangulationHull,
		intersection: types.TriangulationIntersection,
		sweep: types.TriangulationSweep,
	},
	point: types.Point,
	ray: types.Ray,
	rectangle: types.Rectangle,
	segment: types.Segment,
	simple: {
		triangulate: (contours: { { number } }) -> { { number } },
		polygonize: ((n: number, contours: { { number } }) -> { { number } })
			& ((contours: { { number } }) -> { { number } }),
		newUnionClipOperation: (
			subject: { { number } } | types.GeometrySimpleClipOperation,
			other: { { number } } | types.GeometrySimpleClipOperation
		) -> types.GeometrySimpleClipOperation,
		newDifferenceClipOperation: (
			subject: { { number } } | types.GeometrySimpleClipOperation,
			other: { { number } } | types.GeometrySimpleClipOperation
		) -> types.GeometrySimpleClipOperation,
		newIntersectionClipOperation: (
			subject: { { number } } | types.GeometrySimpleClipOperation,
			other: { { number } } | types.GeometrySimpleClipOperation
		) -> types.GeometrySimpleClipOperation,
		clip: (
			operation: types.GeometrySimpleClipOperation,
			subject: { { number } },
			maxVertexCount: number?
		) -> { { number } },
	},
	transform: types.Transform,
}
local meta = require("@slick/meta")
local navigation = require("@slick/navigation") :: {
	edge: types.NavigationEdge,
	mesh: types.NavigationMesh,
	meshBuilder: types.NavigationMeshBuilder,
	path: types.NavigationPath,
	triangle: types.NavigationTriangle,
	vertex: types.NavigationVertex,
}
local options = require("@slick/options") :: types.Options
local responses = require("@slick/responses") :: {
	slide: types.ResponseSlide,
	touch: types.ResponseTouch,
	cross: types.ResponseCross,
	bounce: types.ResponseBounce,
}
local shape = require("@slick/shape") :: {
	newRectangle: (
		x: number,
		y: number,
		w: number,
		h: number,
		tag: (types.Tag | types.Enum)?
	) -> types.ShapeDefinition,
	newCircle: (
		x: number,
		y: number,
		radius: number,
		segments: number?,
		tag: (types.Tag | types.Enum)?
	) -> types.ShapeDefinition,
	newPolygon: (points: { number }, tag: (types.Tag | types.Enum)?) -> types.ShapeDefinition,
	newLineSegment: (
		x1: number,
		y1: number,
		x2: number,
		y2: number,
		tag: (types.Tag | types.Enum)?
	) -> types.ShapeDefinition,
	newChain: (points: { number }, tag: (types.Tag | types.Enum)?) -> types.ShapeDefinition,
	newPolyline: (points: { number }, tag: (types.Tag | types.Enum)?) -> types.ShapeDefinition,
	newPolygonMesh: (contours: { { number } }, tag: (types.Tag | types.Enum)?) -> types.ShapeDefinition,
	newMesh: (polygons: { { number } }, tag: (types.Tag | types.Enum)?) -> types.ShapeDefinition,
	newShapeGroup: (...types.ShapeDefinition | types.Tag) -> types.ShapeDefinition,
}
local tag = require("@slick/tag") :: types.Tag
local util = require("@slick/util")
local world = require("@slick/world") :: types.World
local worldQuery = require("@slick/worldQuery") :: types.WorldQuery
local worldQueryResponse = require("@slick/worldQueryResponse") :: types.WorldQueryResponse

return {
	_VERSION = meta._VERSION,
	_DESCRIPTION = meta._DESCRIPTION,
	_URL = meta._URL,
	_LICENSE = meta._LICENSE,

	cache = cache,
	collision = collision,
	defaultOptions = options,
	entity = entity,
	geometry = geometry,
	shape = shape,
	tag = tag,
	util = util,
	world = world,
	worldQuery = worldQuery,
	worldQueryResponse = worldQueryResponse,
	responses = responses,

	newCache = cache.new,
	newWorld = world.new,
	newWorldQuery = worldQuery.new,
	newTransform = geometry.transform.new,

	newRectangleShape = shape.newRectangle,
	newChainShape = shape.newChain,
	newCircleShape = shape.newCircle,
	newLineSegmentShape = shape.newLineSegment,
	newPolygonShape = shape.newPolygon,
	newPolygonMeshShape = shape.newPolygonMesh,
	newPolylineShape = shape.newPolyline,
	newMeshShape = shape.newMesh,
	newShapeGroup = shape.newShapeGroup,
	newEnum = enum.new,
	newTag = tag.new,

	triangulate = geometry.simple.triangulate,
	polygonize = geometry.simple.polygonize,
	clip = geometry.simple.clip,

	newUnionClipOperation = geometry.simple.newUnionClipOperation,
	newIntersectionClipOperation = geometry.simple.newIntersectionClipOperation,
	newDifferenceClipOperation = geometry.simple.newDifferenceClipOperation,

	navigation = navigation,

	drawWorld = if _G.LUA_ENV == "roblox" then nil else draw,
}
