module.exports = {
    tutorialSidebar: [
        'intro',
        {
            type: 'category',
            label: 'Solution',
            items: ['solution/overview'],
        },
        {
            type: 'category',
            label: 'Architecture',
            items: ['architecture/overview'],
        },
        {
            type: 'category',
            label: 'Installation',
            items: [
                'installation/quickstart',
                'installation/services',
            ],
        },
        {
            type: 'category',
            label: 'Usage',
            items: [
                'usage/qr-citizen',
                'usage/admin-dashboard',
            ],
        },
        {
            type: 'category',
            label: 'Resources',          // ✅ NEW
            items: [
                'resources/github-projects' // ✅ NEW PAGE
            ],
        },
        'about',  // ✅ NEW - Add at bottom
    ],
};
