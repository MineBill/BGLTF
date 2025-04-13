using System;

namespace BGLTF;

typealias SizeT = System.Interop.c_size;
typealias Bool = System.Interop.c_int;

[CRepr]
public enum FileType
{
	Invalid,
	GLTF,
	GLB,
}

[CRepr]
public enum CGLTFResult
{
	Success,
	DataTooShort,
	UnknownFormat,
	InvalidJson,
	InvalidGltf,
	InvalidOptions,
	FileNotFound,
	IOError,
	OutOfMemory,
	LegacyGltf,
}

[CRepr]
public struct MemoryOptions
{
	public function void*(void* user, SizeT size) AllocFunc;
	public function void(void* user, void* ptr) FreeFunc;
}

[CRepr]
public struct FileOptions
{
	public function void*(MemoryOptions* memoryOptions, FileOptions* fileOptions, SizeT* size, void** data) Read;
	public function void(MemoryOptions* memoryOptions, FileOptions* fileOptions, void* data) Release;
	public void* UserData;
}

[CRepr]
public struct Options
{
	public FileType Type;
	public uint64 JsonTokenCount;
	public MemoryOptions Memory;
	public FileOptions File;
}

[CRepr]
public enum BufferViewType
{
	Invalid,
	Indices,
	Vertices,
}

[CRepr]
public enum AttributeType
{
	Invalid,
	Position,
	Normal,
	Tangent,
	Texcoord,
	Color,
	Joints,
	Weights,
	Custom,
}

[CRepr]
public enum ComponentType
{
	Invalid,
	R8,
	R8u,
	R16,
	R16u,
	R32u,
	R32f,
}

[CRepr]
public enum Type
{
	Invalid,
	Scalar,
	Vec2,
	Vec3,
	Vec4,
	Mat2,
	Mat3,
	Mat4,
}

[CRepr]
public enum PrimitiveType
{
	Invalid,
	Points,
	Line,
	LineLoop,
	LineStrip,
	Triangles,
	TriangleStrip,
	TriangleFan,
}

[CRepr]
public enum AlphaMode
{
	Opaque,
	Mask,
	Blend,
}

[CRepr]
public enum AnimationPathType
{
	Invalid,
	Translation,
	Rotation,
	Scale,
	Weights,
}

[CRepr]
public enum InterpolationType
{
	Linear,
	Step,
	CubicSpline,
}

[CRepr]
public enum CameraType
{
	Invalid,
	Directional,
	Point,
	Spot,
}

[CRepr]
public enum LightType
{
	Invalid,
	Directional,
	Point,
	Spot,
}

[CRepr]
public enum DataFreeMethod
{
	None,
	FileRelease,
	MemoryFree,
}

[CRepr]
public struct Extras
{
	public SizeT StartOffset;
	public SizeT EndOffset;

	public char8* Data;
	/*char* data*/
}

[CRepr]
public struct Extension
{
	public char8* Name;
	public char8* Data;
}

[CRepr]
public struct Buffer
{
	public char8* Name;
	public SizeT Size;
	public char8* Uri;
	public void* Data;
	public DataFreeMethod DataFreeMethod;
	public Extras Extras;
	public SizeT ExtensionsCount;
	public Extension* Extensions;
}

[CRepr]
public enum MeshoptCompressionMode
{
	Invalid,
	Attributes,
	Triangles,
	Indices,
}

[CRepr]
public enum MeshoptCompressionFilter
{
	None,
	Octahedral,
	Quaternion,
	Exponential,
}

[CRepr]
public struct MeshoptCompression
{
	public Buffer* Buffer;
	public SizeT Offset;
	public SizeT Size;
	public SizeT Stride;
	public SizeT Count;
	public MeshoptCompressionMode Mode;
	public MeshoptCompressionFilter Filter;
}

[CRepr]
public struct BufferView
{
	public char8* Name;
	public Buffer* Buffer;
	public SizeT Offset;
	public SizeT Size;
	public SizeT Stride; /* 0 == automatically determined by accessor */
	public BufferViewType Type;
	public void* Data; /* overrides buffer->data if present, filled by extensions */
	public Bool HasMeshoptCompression;
	public MeshoptCompression MeshoptCompression;
	public Extras Extras;
	public SizeT ExtensionsCount;
	public Extension* Extensions;
}

[CRepr]
public struct AccessorSparse
{
	public SizeT Count;
	public BufferView* IndicesBufferView;
	public SizeT IndicesByteOffset;
	public ComponentType IndicesComponentType;
	public BufferView* ValuesBufferView;
	public SizeT ValuesByteOffset;
}

[CRepr]
public struct Accessor
{
	public char8* Name;
	public ComponentType ComponentType;
	public Bool Normalized;
	public BGLTF.Type Type;
	public SizeT Offset;
	public SizeT Count;
	public SizeT Stride;
	public BufferView* BufferView;

	public Bool HasMin;
	public float[16] Min;

	public Bool HasMax;
	public float[16] Max;

	public Bool IsSparse;
	public AccessorSparse Sparse;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Attribute
{
	public char8* Name;
	public AttributeType Type;
	public int32 Index;
	public Accessor* Data;
}

[CRepr]
public struct Image
{
	public char8* Name;
	public char8* Uri;
	public BufferView BufferView;
	public char8* MimeType;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Sampler
{
	public char8* Name;
	public int32 MagFilter;
	public int32 MinFilter;
	public int32 WrapS;
	public int32 WrapT;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Texture
{
	public char8* Name;
	public Image* Image;
	public Sampler* Sampler;

	public Bool HasBasisu;
	public Image* BasisuImage;

	public Bool HasWebp;
	public Image* WebpImage;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);

}

[CRepr]
public struct TextureTransform
{
	public float[2] Offset;
	public float Rotation;
	public float[2] Scale;
	public Bool HasTexCoord;
	public int32 TexCoord;
}

[CRepr]
public struct TextureView
{
	public Texture* Texture;
	public int32 TexCoord;
	public float Scale; /* equivalent to strength for occlusion_texture */
	public Bool HasTransform;
	public TextureTransform Transform;
}

[CRepr]
public struct PbrMetallicRoughness
{
	public TextureView BaseColorTexture;
	public TextureView MetallicRoughnessTexture;

	public float[4] BaseColorFactor;
	public float MetallicFactor;
	public float RoughnessFactor;
}

[CRepr]
public struct PbrSpecularGlossiness
{
	public TextureView DiffuseTexture;
	public TextureView SpecularGlossinessTexture;

	public float[4] DiffuseFactor;
	public float[3] SpecularFactor;
	public float GlossinessFactor;
}

[CRepr]
public struct Clearcoat
{
	public TextureView ClearcoatTexture;
	public TextureView ClearcoatRougnessTexture;
	public TextureView ClaercoatNormalTexture;

	public float ClearcoatFactor;
	public float ClearcoatRoughnessFactor;
}

[CRepr]
public struct Transmission
{
	public TextureView TransmissionTexture;
	public float TransmissionFactor;
}

[CRepr]
public struct Ior
{
	public float Ior;
}

[CRepr]
public struct Specular
{
	public TextureView SpecularTexture;
	public TextureView SpecularColorTexture;
	public float[3] SpecularColorFactor;
	public float SpecularFactor;
}

[CRepr]
public struct Volume
{
	public TextureView ThicknessTexture;
	public float ThicknessFactor;
	public float[3] AttenuationColor;
	public float AttenuationDistance;
}

[CRepr]
public struct Sheen
{
	public TextureView SheenColorTexture;
	public float[3] SheenColorFactor;
	public TextureView SheenRoughnessTeture;
	public float SheenRoughnessFactor;
}

[CRepr]
public struct EmissiveStrength
{
	public float EmissiveStrength;
}

[CRepr]
public struct Iridescence
{
	public float IridescenceFactor;
	public TextureView IridescenceTexture;
	public float IridescenceIor;
	public float IridescenceThicknessMin;
	public float IridescenceThicknessMax;
	public TextureView IridescenceThicknessTexture;
}

[CRepr]
public struct DiffuseTransmission
{
	public TextureView DiffuseTransmissionTexture;
	public float DiffuseTransmissionFactor;
	public float[3] DiffuseTransmissionColorFactor;
	public TextureView DiffuseTransmissionColorTexture;
}

[CRepr]
public struct Anisotropy
{
	public float AnisotropyStrenght;
	public float AnisotropyRotation;
	public TextureView AnisotropyTexture;
}

[CRepr]
public struct Dispersion
{
	public float Dispersion;
}

[CRepr]
public struct Material
{
	public char8* Name;

	public Bool HasPbrMetallicRoughness;
	public Bool HasPbrSpecularGlossines;
	public Bool HasClearcoat;
	public Bool HasTransmission;
	public Bool HasVolume;
	public Bool HasIor;
	public Bool HasSpecular;
	public Bool HasSheen;
	public Bool HasEmissiveStrength;
	public Bool HasIridescence;
	public Bool HasDiffuseTransmission;
	public Bool HasAnisotropy;
	public Bool HasDispersion;

	public PbrMetallicRoughness MetallicRoughness;
	public PbrSpecularGlossiness SpecularGlossiness;
	public Clearcoat Clearcoat;
	public Ior Ior;
	public Specular Specular;
	public Sheen Sheen;
	public Transmission Transmission;
	public Volume Volume;
	public EmissiveStrength EmissiveStrenght;
	public Iridescence Iridescence;
	public DiffuseTransmission DiffuseTransmission;
	public Anisotropy Anisotropy;
	public Dispersion Dispersion;

	public TextureView NormalTexture;
	public TextureView OcclusionTexture;
	public TextureView EmissiveTexture;

	public float[3] EmissiveFactor;
	public AlphaMode AlphaMode;
	public float AlphaCutoff;
	public Bool DoubleSided;
	public Bool Unlit;
	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct MaterialMapping
{
	public SizeT Variant;
	public Material* Material;
	public Extras Extras;
}

[CRepr]
public struct MorphTarget
{
	private BGLTF.Attribute* m_Attributes;
	private SizeT m_AttributesCount;

	public Span<BGLTF.Attribute> Attributes => .(m_Attributes, (int)m_AttributesCount);
}

[CRepr]
public struct DracoMeshCompression
{
	public BufferView* BufferView;

	private BGLTF.Attribute* m_Attributes;
	private SizeT m_AttributesCount;

	public Span<BGLTF.Attribute> Attributes => .(m_Attributes, (int)m_AttributesCount);
}

[CRepr]
public struct MeshGpuInstancing
{
	private BGLTF.Attribute* m_Attributes;
	private SizeT m_AttributesCount;

	public Span<BGLTF.Attribute> Attributes => .(m_Attributes, (int)m_AttributesCount);
}

[CRepr]
public struct Primitive
{
	public PrimitiveType Type;
	public Accessor* Indicies;
	public Material* Material;

	private BGLTF.Attribute* m_Attributes;
	private SizeT m_AttributesCount;

	public Span<BGLTF.Attribute> Attributes => .(m_Attributes, (int)m_AttributesCount);

	private MorphTarget* m_Targets;
	private SizeT m_TargetsCount;

	public Span<MorphTarget> Targets => .(m_Targets, (int)m_TargetsCount);

	public Extras Extras;

	public Bool HasDracoMeshCompression;
	public DracoMeshCompression DracoMeshCompression;

	private MaterialMapping* m_Mappings;
	private SizeT m_MappingsCount;


	public Span<MaterialMapping> Mappings => .(m_Mappings, (int)m_MappingsCount);

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Mesh
{
	public char8* Name;

	private Primitive* m_Primitives;
	private SizeT m_PrimitivesCount;

	public Span<Primitive> Primitives => .(m_Primitives, (int)m_PrimitivesCount);

	private float* m_Weights;
	private SizeT m_WeightsCount;

	public Span<float> Weights => .(m_Weights, (int)m_WeightsCount);


	private char8** m_TargetNames;
	private SizeT m_TargetNamesCount;

	public Span<char8*> TargetNames => .(m_TargetNames, (int)m_TargetNamesCount);

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Skin
{
	public char8* Name;

	private Node** m_Joints;
	private SizeT m_JointsCount;

	public Span<Node*> Joints => .(m_Joints, (int)m_JointsCount);

	public Node* Skeleton;
	public Accessor* InverseBindMatrices;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct CameraPerspective
{
	public Bool HasAspectRatio;
	public float AspectRatio;
	public float YFov;
	public Bool HasZFar;
	public float ZFar;
	public float ZNear;

	public Extras Extras;
}

[CRepr]
public struct CameraOrthographic
{
	public float XMag;
	public float YMag;
	public float ZFar;
	public float ZNear;

	public Extras Extras;
}

[CRepr]
public struct Camera
{
	public char8* Name;
	public CameraType Type;

	public [Union] struct
	{
		CameraPerspective Perspective;
		CameraOrthographic Orthographic;
	} Data;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Light
{
	public char8* Name;
	public float[3] Color;
	public float Inensity;
	public LightType Type;
	public float Range;
	public float SpotInnerConeAngle;
	public float SpotOuterConeAngle;

	public Extras Extras;
}

[CRepr]
public struct Node
{
	public char8* Name;

	public Node* Parent;

	private Node** m_Children;
	private SizeT m_ChildrenCount;

	public Span<Node*> Children => .(m_Children, (int)m_ChildrenCount);

	public Skin* Skin;
	public Mesh* Mesh;
	public Camera* Camera;
	public Light* Light;

	private float* m_Weights;
	private SizeT m_WeightsCount;

	public Span<float> Weights => .(m_Weights, (int)m_WeightsCount);

	public Bool HasTranslation;
	public Bool HasRotation;
	public Bool HasScale;
	public Bool HasMatrix;

	public float[3] Translation;
	public float[4] Rotation;
	public float[3] Scale;
	public float[16] Matrix;

	public Extras Extras;
	public Bool HasMeshGpuInstancing;
	public MeshGpuInstancing MeshGpuInstancing;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Scene
{
	public char8* Name;

	private Node** m_Nodes;
	private SizeT m_NodesCount;

	public Span<Node*> Nodes => .(m_Nodes, (int)m_NodesCount);

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct AnimationSampler
{
	public Accessor* Input;
	public Accessor* Output;
	public InterpolationType Interpolation;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct AnimationChannel
{
	public AnimationSampler* Sampler;
	public Node* TargetNode;
	public AnimationPathType TargetPath;

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Animation
{
	public char8* Name;

	private AnimationSampler* m_Samplers;
	private SizeT m_SamplersCount;

	public Span<AnimationSampler> Samplers => .(m_Samplers, (int)m_SamplersCount);

	private AnimationChannel* m_Channels;
	private SizeT m_ChannelsCount;

	public Span<AnimationChannel> Channels => .(m_Channels, (int)m_ChannelsCount);

	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct MaterialVariant
{
	public char8* Name;
	public Extras Extras;
}

[CRepr]
public struct Asset
{
	public char8* Copyright;
	public char8* Generator;
	public char8* Version;
	public char8* MinVersion;
	public Extras Extras;

	private SizeT m_ExtensionsCount;
	private Extension* m_Extensions;

	public Span<Extension> Extensions => .(m_Extensions, (int)m_ExtensionsCount);
}

[CRepr]
public struct Data
{
	public FileType FileType;
	public void* FileData;

	public Asset Asset;

	private Mesh* m_Meshes;
	private SizeT m_MeshesCount;
	public Span<Mesh> Meshes => .(m_Meshes, (int)m_MeshesCount);

	private Material* m_Materials;
	private SizeT m_MaterialsCount;
	public Span<Material> Materials => .(m_Materials, (int)m_MaterialsCount);

	private Accessor* m_Accessors;
	private SizeT m_AccessorsCount;
	public Span<Accessor> Accessors => .(m_Accessors, (int)m_AccessorsCount);

	private BufferView* m_BufferViews;
	private SizeT m_BufferViewsCount;
	public Span<BufferView> BufferViews => .(m_BufferViews, (int)m_BufferViewsCount);

	private Buffer* m_Buffers;
	private SizeT m_BuffersCount;
	public Span<Buffer> Buffers => .(m_Buffers, (int)m_BuffersCount);

	private Image* m_Images;
	private SizeT m_ImagesCount;
	public Span<Image> Images => .(m_Images, (int)m_ImagesCount);

	private Texture* m_Textures;
	private SizeT m_TexturesCount;
	public Span<Texture> Textures => .(m_Textures, (int)m_TexturesCount);

	private Sampler* m_Samplers;
	private SizeT m_SamplersCount;
	public Span<Sampler> Samplers => .(m_Samplers, (int)m_SamplersCount);

	private Skin* m_Skins;
	private SizeT m_SkinsCount;
	public Span<Skin> Skins => .(m_Skins, (int)m_SkinsCount);

	private Camera* m_Cameras;
	private SizeT m_CamerasCount;
	public Span<Camera> Cameras => .(m_Cameras, (int)m_CamerasCount);

	private Light* m_Lights;
	private SizeT m_LightsCount;
	public Span<Light> Lights => .(m_Lights, (int)m_LightsCount);

	private Node* m_Nodes;
	private SizeT m_NodesCount;
	public Span<Node> Nodes => .(m_Nodes, (int)m_NodesCount);

	private Scene* m_Scenes;
	private SizeT m_ScenesCount;
	public Span<Scene> Scenes => .(m_Scenes, (int)m_ScenesCount);

	public Scene* Scene;

	private Animation* m_Animations;
	private SizeT m_AnimationsCount;
	public Span<Animation> Animations => .(m_Animations, (int)m_AnimationsCount);

	private MaterialVariant* m_Variants;
	private SizeT m_VariantsCount;
	public Span<MaterialVariant> Variants => .(m_Variants, (int)m_VariantsCount);

	private Extension* m_DataExtensions;
	private SizeT m_DataExtensionsCount;
	public Span<Extension> DataExtensions => .(m_DataExtensions, (int)m_DataExtensionsCount);

	private char8** m_ExtensionsUsed;
	private SizeT m_ExtensionsUsedCount;
	public Span<char8*> ExtensionsUsed => .(m_ExtensionsUsed, (int)m_ExtensionsUsedCount);

	private char8** m_ExtensionsRequired;
	private SizeT m_ExtensionsRequiredCount;
	public Span<char8*> ExtensionsRequired => .(m_ExtensionsRequired, (int)m_ExtensionsRequiredCount);

	public char8* Json;
	public SizeT JsonSize;

	public void* Bin;
	public SizeT BinSize;

	public MemoryOptions Memory;
	public FileOptions File;
}