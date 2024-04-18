import { baseEslintConfig, prettierConfig } from "@spear-ai/eslint-config";

/** @type {import("eslint").Linter.FlatConfig} */
const eslintConfig = [
  {
    ignores: [".mypy_cache/**", "packages/**", "target/**"],
  },
  ...baseEslintConfig,
  prettierConfig,
];

export default eslintConfig;
