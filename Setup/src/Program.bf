using System;
using BeefLibSetupHelper;

namespace Setup;

class Program
{
	public static void Main()
	{
		SetupHelper.CheckDeps!();
		SetupHelper.ConfigureAndBuild("cgltf");
	}
}