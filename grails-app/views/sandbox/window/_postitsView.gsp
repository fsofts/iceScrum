<%@ page import="org.icescrum.core.domain.Story; grails.converters.JSON" %>
%{--
- Copyright (c) 2010 iceScrum Technologies.
-
- This file is part of iceScrum.
-
- iceScrum is free software: you can redistribute it and/or modify
- it under the terms of the GNU Affero General Public License as published by
- the Free Software Foundation, either version 3 of the License.
-
- iceScrum is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
-
- You should have received a copy of the GNU Affero General Public License
- along with iceScrum.  If not, see <http://www.gnu.org/licenses/>.
-
- Authors:
-
- Vincent Barrier (vbarrier@kagilum.com)
- Damien vitrac (damien@oocube.com)
- Manuarii Stein (manuarii.stein@icescrum.com)
- Stephane Maldini (stephane.maldini@icescrum.com)
--}%

<g:set var="productOwner" value="${request.productOwner}"/>
<is:backlogElementLayout
        emptyRendering="true"
        style="display:${stories ? 'block' : 'none'};"
        id="window-${controllerName}"
        selectable="[filter:'div.postit-story',
                    cancel:'.postit-label, a',
                    selected:'jQuery.icescrum.dblclickSelectable(ui,300,$.icescrum.displayQuicklook)']"
        droppable='[selector:"div.postit",
                  hoverClass: "ui-selected",
                  drop: remoteFunction(controller:"story",
                                       action:"associateFeature",
                                       onSuccess:"jQuery.event.trigger(\"update_story\",data)",
                                       params:"\"product=${params.product}&feature.id=\"+ui.draggable.data(\"elemid\")+\"&id=\"+jQuery(this).data(\"elemid\")"
                                       ),
                  accept: ".postit-row-feature"]'
        dblclickable='[rendered:!productOwner,selector:".postit",callback:"\$.icescrum.displayQuicklook(obj);"]'
        value="${stories}"
        var="story">
        <is:cache  cache="storyCache" key="postit-${story.id}-${story.lastUpdated}-${sprint ? sprint.id : ''}">
            <g:render template="/story/postit" model="[story:story,user:user, sprint:sprint]"/>
        </is:cache>
</is:backlogElementLayout>

<g:render template="/sandbox/window/blank" model="[show:stories ? false : true]"/>

<is:dropImport id="${controllerName}" description="is.ui.sandbox.drop.import" action="dropImport" success="jQuery(document.body).append(data.dialog);attachOnDomUpdate(jQuery('.ui-dialog'));"/>

<jq:jquery>
    jQuery('#window-title-bar-${controllerName} .content .details').html(' (<span id="stories-sandbox-size">${stories?.size()}</span>)');
</jq:jquery>

<is:shortcut key="space"
             callback="if(jQuery('#dialog').dialog('isOpen') == true){jQuery('#dialog').dialog('close'); return false;}jQuery.icescrum.dblclickSelectable(null,null,\$.icescrum.displayQuicklook,true);"
             scope="${controllerName}"/>
<is:shortcut key="ctrl+a" callback="jQuery('#backlog-layout-window-${controllerName} .ui-selectee').addClass('ui-selected');"/>

<is:onStream
        on="#backlog-layout-window-${controllerName}"
        events="[[object:'story',events:['add','update','remove','accept','associated','dissociated','returnToSandbox']]]"
        template="sandbox"/>

<is:onStream
        on="#backlog-layout-window-${controllerName}"
        events="[[object:'sprint',events:['close','activate']]]"/>

<is:onStream
        on="#backlog-layout-window-${controllerName}"
        events="[[object:'feature',events:['update']]]"/>