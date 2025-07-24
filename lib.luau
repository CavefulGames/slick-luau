local cache = require("@slick/cache")
local collision = require("@slick/collision")
local draw = require("@slick/draw")
local entity = require("@slick/entity")
local enum = require("@slick/enum")
local geometry = require("@slick/geometry")
local meta = require("@slick/meta")
local navigation = require("@slick/navigation")
local options = require("@slick/options")
local responses = require("@slick/responses")
local shape = require("@slick/shape")
local tag = require("@slick/tag")
local util = require("@slick/util")
local world = require("@slick/world")
local worldQuery = require("@slick/worldQuery")
local worldQueryResponse = require("@slick/worldQueryResponse")

return {
	_VERSION = meta._VERSION,
	_DESCRIPTION = meta._DESCRIPTION,
	_URL = meta._URL,
	_LICENSE = meta._LICENSE,

	--- @class slick.cache
	--- @field triangulator slick.geometry.triangulation.delaunay
	cache = cache :: any,
	collision = collision :: any,
	--- @class slick.options
	--- @field epsilon number?
	--- @field maxBounces number?
	--- @field maxJitter number?
	--- @field debug boolean?
	--- @field quadTreeX number?
	--- @field quadTreeY number?
	--- @field quadTreeMaxLevels number?
	--- @field quadTreeMaxData number?
	--- @field quadTreeExpand boolean?
	--- @field quadTreeOptimizationMargin number?
	--- @field sharedCache slick.cache?
	defaultOptions = options :: any,
	--- @class slick.entity
	--- @field item any?
	--- @field world slick.world?
	--- @field bounds slick.geometry.rectangle
	--- @field shapes slick.collision.shapeGroup
	--- @field transform slick.geometry.transform
	entity = entity :: any,
	geometry = geometry :: any,
	shape = shape :: any,
	--- @class slick.tag
	--- @field value any
	tag = tag :: any,
	util = util :: any,
	--- @class slick.world
	--- @field cache slick.cache
	--- @field quadTree slick.collision.quadTree
	--- @field options slick.options
	--- @field quadTreeOptions slick.collision.quadTreeOptions
	--- @field private responses table<string, slick.worldResponseFunc>
	--- @field private entities slick.entity[]
	--- @field private itemToEntity table<any, number>
	--- @field private previousEntityCollisions table<slick.entity, slick.worldQuery>
	--- @field private freeWorldQueries slick.worldQuery[]
	--- @field private freeList number[]
	--- @field private cachedQuery slick.worldQuery
	--- @field private cachedPushQuery slick.worldQuery
	world = world :: any,
	--- @class slick.worldQuery
	--- @field world slick.world
	--- @field quadTreeQuery slick.collision.quadTreeQuery
	--- @field results slick.worldQueryResponse[]
	--- @field private cachedResults slick.worldQueryResponse[]
	--- @field private collisionQuery slick.collision.shapeCollisionResolutionQuery
	--- @field pools table<any, slick.util.pool> **internal**
	worldQuery = worldQuery :: any,
	worldQueryResponse = worldQueryResponse :: any,
	responses = responses :: any,

	--- @param options slick.options
	newCache = cache.new :: any,
	--- @param width number
	--- @param height number
	--- @param options slick.options?
	newWorld = world.new :: any,
	--- @class slick.worldQueryResponse
	--- @field query slick.worldQuery
	--- @field response string | slick.worldVisitFunc | true
	--- @field item any
	--- @field entity slick.entity
	--- @field shape slick.collision.shape
	--- @field other any?
	--- @field otherEntity slick.entity?
	--- @field otherShape slick.collision.shape?
	--- @field normal slick.geometry.point
	--- @field depth number
	--- @field time number
	--- @field offset slick.geometry.point
	--- @field touch slick.geometry.point
	--- @field isProjection boolean
	--- @field contactPoint slick.geometry.point
	--- @field contactPoints slick.geometry.point[]
	--- @field segment slick.geometry.segment
	--- @field distance number
	--- @field extra table
	newWorldQuery = worldQuery.new :: any,
	--- Constructs a new transform.
	--- @param x number? translation on the x axis (defaults to 0)
	--- @param y number? translation on the y axis (defaults to 0)
	--- @param rotation number? rotation in radians (defaults to 0)
	--- @param scaleX number? scale along the x axis (defaults to 1)
	--- @param scaleY number? scale along the y axis (defaults to 1)
	--- @param offsetX number? offset along the x axis (defaults to 0)
	--- @param offsetY number? offsete along the y axis (defaults to 0)
	newTransform = geometry.transform.new :: any,

	--- @param x number
	--- @param y number
	--- @param w number
	--- @param h number
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newRectangleShape = shape.newRectangle :: any,
	--- @param points number[] an array of points in the form { x1, y2, x2, y2, ... }
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newChainShape = shape.newChain :: any,
	--- @param x number
	--- @param y number
	--- @param radius number
	--- @param segments number?
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newCircleShape = shape.newCircle :: any,
	--- @param x1 number
	--- @param y1 number
	--- @param x2 number
	--- @param y2 number
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newLineSegmentShape = shape.newLineSegment :: any,
	--- @param vertices number[] a list of x, y coordinates in the form `{ x1, y1, x2, y2, ..., xn, yn }`
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newPolygonShape = shape.newPolygon :: any,
	--- @param vertices number[] a list of x, y coordinates in the form `{ x1, y1, x2, y2, ..., xn, yn }`
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newPolygonMeshShape = shape.newPolygonMesh :: any,
	--- @param ... number[] | slick.tag | slick.enum a list of x, y coordinates in the form `{ x1, y1, x2, y2, ..., xn, yn }`
	--- @return slick.collision.shapeDefinition
	newPolylineShape = shape.newPolyline :: any,
	--- @param polygons number[][] an array of segments in the form { { x1, y1, x2, y2, x3, y3, ..., xn, yn }, ... }
	--- @param tag slick.tag | slick.enum | nil
	--- @return slick.collision.shapeDefinition
	newMeshShape = shape.newMesh :: any,
	--- @param ... slick.collision.shapeDefinition | slick.tag
	--- @return slick.collision.shapeDefinition
	newShapeGroup = shape.newShapeGroup :: any,
	newEnum = enum.new :: any,
	newTag = tag.new :: any,

	--- @param contours number[][]
	--- @return number[][]
	triangulate = geometry.simple.triangulate :: any,
	--- @overload fun(n: number, contours: number[][]): number[][]
	--- @overload fun(contours: number[][]): number[][]
	--- @return number[][]
	polygonize = geometry.simple.polygonize :: any,
	--- @param operation slick.simple.clipOperation
	--- @param maxVertexCount number?
	--- @return number[][]
	clip = geometry.simple.clip :: any,

	--- @param subject number[][] | slick.simple.clipOperation
	--- @param other number[][] | slick.simple.clipOperation
	--- @return slick.simple.clipOperation
	newUnionClipOperation = geometry.simple.newUnionClipOperation :: any,
	--- @param subject number[][] | slick.simple.clipOperation
	--- @param other number[][] | slick.simple.clipOperation
	--- @return slick.simple.clipOperation
	newIntersectionClipOperation = geometry.simple.newIntersectionClipOperation :: any,
	--- @param subject number[][] | slick.simple.clipOperation
	--- @param other number[][] | slick.simple.clipOperation
	--- @return slick.simple.clipOperation
	newDifferenceClipOperation = geometry.simple.newDifferenceClipOperation :: any,

	navigation = navigation :: any,

	--- *Only works in LÖVE environment!*
	--- @param world slick.world
	--- @param queries { filter: slick.worldShapeFilterQueryFunc, shape: slick.geometry.shape }[]?
	--- @param options slick.draw.options?
	drawWorld = draw :: any,
}
