/*
 * Copyright (c) 2017 Kagilum SAS.
 *
 * This file is part of iceScrum.
 *
 * iceScrum is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License.
 *
 * iceScrum is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with iceScrum.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors:
 *
 * Vincent Barrier (vbarrier@kagilum.com)
 * Nicolas Noullet (nnoullet@kagilum.com)
 *
 */

services.service("AppService", ['Session', 'FormService', function(Session, FormService) {
    var self = this;
    this.updateEnabledForProject = function(appDefinition, enabledForProject) {
        return FormService.httpPost('app/updateEnabledForProject', {appDefinitionId: appDefinition.id, enabledForProject: enabledForProject}, null, false);
    };
    this.getAppDefinitions = function() {
        return FormService.httpGet('app/definitions', null, false);
    };
    this.getAppDefinitionsWithProjectSettings = function() {
        return self.getAppDefinitions().then(function(appDefinitions) {
            return _.filter(appDefinitions, function(appDefinition) {
                return self.authorizedApp('updateProjectSettings', appDefinition)
            });
        });
    };
    this.authorizedApp = function(action, appDefinition, project) {
        switch(action) {
            case 'show':
                return Session.authenticated();
            case 'enableForProject':
                return Session.sm() && appDefinition && appDefinition.availableForServer && appDefinition.enabledForServer && appDefinition.isProject;
            case 'updateProjectSettings':
                return self.authorizedApp('enableForProject', appDefinition) && appDefinition.enabledForProject && appDefinition.projectSettings;
            case 'use':
                return project && _.find(project.simpleProjectApps, {appDefinitionId: appDefinition, enabled: true}); // Hack to avoid the need to pass an object, here appDefinition is only the ID
            default:
                return false;
        }
    };
}]);