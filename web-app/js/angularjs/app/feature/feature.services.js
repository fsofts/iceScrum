/*
 * Copyright (c) 2014 Kagilum SAS.
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
services.factory('Feature', [ 'Resource', function ($resource) {
    return $resource('feature/:id/:action', { id: '@id' }, { query: {method: 'GET', isArray: true, cache: true} });
}]);

services.service("FeatureService", ['Feature', '$q', function (Feature, $q) {
    var self = this;
    this.list = Feature.query();
    this.get = function (id) {
        var feature;
        var deferred = $q.defer();
        self.list.$promise.then(function (list) {
            feature = _.find(list, function (rw) {
                return rw.id == id
            });
            deferred.resolve(feature);
        });
        return deferred.promise;
    };
    this.update = function (feature, callback) {
        feature.$update(function (data) {
            var index = self.list.indexOf(_.findWhere(self.list, { id: feature.id }));
            if (index != -1) {
                self.list.splice(index, 1, data);
            }
        });
    };
    this['delete'] = function (feature) {
        feature.$delete(function () {
            var index = self.list.indexOf(feature);
            if (index != -1) {
                self.list.splice(index, 1);
            }
        });
    };
}]);
