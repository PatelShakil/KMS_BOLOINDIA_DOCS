// docusaurus.config.js
const config = {
    title: 'BoloIndia Docs',
    tagline: 'QR-Powered Community Feedback Platform',
    favicon: 'img/logo.png',

    url: 'https://docs.boloindia.techsavvysolution.in',
    baseUrl: '/',

    organizationName: 'boloindia',
    projectName: 'docs',

    onBrokenLinks: 'throw',
    onBrokenMarkdownLinks: 'warn',

    i18n: {
        defaultLocale: 'en',
        locales: ['en'],
    },

    presets: [
        [
            'classic',
            {
                docs: {
                    sidebarPath: './sidebars.js',
                    routeBasePath: '/',
                    // ✅ Enable Mermaid diagrams
                    remarkPlugins: [],
                },
                blog:false,
                theme: {
                    customCss: './src/css/custom.css',
                },
            },
        ],
    ],

    // ✅ Mermaid support
    markdown: {
        mermaid: true,
    },
    themes: [
        '@docusaurus/theme-mermaid',
    ],

    themeConfig: {
        navbar: {
            title: 'BoloIndia',
            logo: {
                alt: 'BoloIndia Logo',
                src: 'img/logo.png',
            },
            items: [
                {
                    type: 'docSidebar',
                    sidebarId: 'tutorialSidebar',
                    position: 'left',
                    label: 'Docs',
                },
            ],
        },
    },
};

module.exports = config;
